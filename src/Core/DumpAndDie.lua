--[[--
Dumps the values of variables and tables in the output, then dies.

The dd() stands for "dump and die" and it's a helper function inspired by a PHP framework
called Laravel. It's used to dump the values of variables and tables in the output and stop
the execution of the script. It's only used for debugging purposes and should never be used
in an addon that will be released.

Given that it can't use the Output:out() method, there's no test coverage for dd(). After
all it's a test and debugging helper resource.

@param ... The variables and tables to be dumped

@usage
    dd(someVariable)
    dd({ key = 'value' })
    dd(someVariable, { key = 'value' })
]]
function self:dd(...)
    local inGame = self.environment and self.environment:inGame() or false
    
    if not inGame then print('\n\n\27[32m-dd-\n') end
    
    local function printTable(t, indent, printedTables)
        indent = indent or 0
        printedTables = printedTables or {}
        local indentStr = string.rep(" ", indent)
        for k, v in pairs(t) do
            if type(v) == "table" then
                if not printedTables[v] then
                    printedTables[v] = true
                    print(indentStr .. k .. " => {")
                    printTable(v, indent + 4, printedTables)
                    print(indentStr .. "}")
                else
                    print(indentStr .. k .. " => [circular reference]")
                end
            else
                print(indentStr .. k .. " => " .. tostring(v))
            end
        end
    end

    for i, v in ipairs({...}) do
        if type(v) == "table" then
            print("[" .. i .. "] => {")
            printTable(v, 4, {})
            print("}")
        else
            print("[" .. i .. "] => " .. tostring(v))
        end
    end

    -- this prevents os.exit() being called inside the game and also allows
    -- dd() to be tested
    if inGame then return end

    print('\n-end of dd-' .. (not inGame and '\27[0m' or ''))
    lu.unregisterCurrentSuite()
    os.exit(1)
end