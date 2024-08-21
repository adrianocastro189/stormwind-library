TestCommand = BaseTestClass:new()

-- @covers Command:__construct()
TestCase.new()
    :setName('__construct')
    :setTestClass(TestCommand)
    :setExecution(function()
        local command = __:new('Command')

        lu.assertNotIsNil(command)
    end)
    :register()

-- @covers Command:setCallback()
-- @covers Command:setDescription()
-- @covers Command:setOperation()
TestCase.new()
    :setName('chained setters')
    :setTestClass(TestCommand)
    :setExecution(function()
        local command = __:new('Command')

        command
            :setArgsValidator('test-args-validator')
            :setCallback('test-callback')
            :setDescription('test-description')
            :setOperation('test-operation')

        lu.assertEquals('test-args-validator', command.argsValidator)
        lu.assertEquals('test-callback', command.callback)
        lu.assertEquals('test-description', command.description)
        lu.assertEquals('test-operation', command.operation)
    end)
    :register()

-- @covers Command:getHelpContent()
TestCase.new()
    :setName('getHelpContent')
    :setTestClass(TestCommand)
    :setExecution(function(data)
        lu.assertEquals(data.expectedOutput, data.command:getHelpContent())
    end)
    :setScenarios({
        ['empty command'] = function()
            return {
                command = __:new('Command'),
                expectedOutput = nil,
            }
        end,
        ['command without description'] = function()
            return {
                command = __
                    :new('Command')
                    :setOperation('test-operation'),
                expectedOutput = 'test-operation',
            }
        end,
        ['complete command'] = function()
            return {
                command = __
                    :new('Command')
                    :setOperation('test-operation')
                    :setDescription('test-description'),
                expectedOutput = 'test-operation - test-description',
            }
        end,
    })
    :register()

-- @covers Command:validateArgs()
TestCase.new()
    :setName('validateArgs')
    :setTestClass(TestCommand)
    :setExecution(function(data)
        local command = __:new('Command')

        command:setArgsValidator(data.validator)

        lu.assertEquals(data.expectedOutput, command:validateArgs())
    end)
    :setScenarios({
        ['no validator'] = {
            validator = nil,
            expectedOutput = 'valid',
        },
        ['validator returning invalid'] = {
            validator = function() return 'invalid' end,
            expectedOutput = 'invalid',
        },
    })
    :register()

-- @covers Command:validateArgs()
TestCase.new()
    :setName('validateArgs with multiple parameters')
    :setTestClass(TestCommand)
    :setExecution(function()
        local command = __:new('Command')

        -- makes sure the arguments are being passed to the validator
        command:setArgsValidator(function(arg1, arg2)
            command.arg1 = arg1
            command.arg2 = arg2
        end)

        command:validateArgs('arg1', 'arg2')

        lu.assertEquals('arg1', command.arg1)
        lu.assertEquals('arg2', command.arg2)
    end)
    :register()
-- end of TestCommand
