const fs = require('fs');
const path = require('path');

/**
 * Wrapper for the Stormwind Library file located in the src directory.
 */
class StormwindLibrary {
    /**
     * Builds the library.
     */
    build = () => {
        this.read();

        this.importFiles();
        this.fileContent = this.wrapLibraryMainFunction();

        this.write();
    }

    /**
     * Gets the library version in snake case.
     * 
     * @param {string} separator 
     * @returns 
     */
    getVersionInSnakeCase = (separator = '_') => {
        return this.parseVersion().replace(/\./g, separator);
    }

    /**
     * Imports a file by replacing the import line instruction with the file content.
     * 
     * @param {string} filePath 
     */
    importFile = (filePath) => {
        let fileContent = fs.readFileSync(`../${filePath}`, 'utf8');

        // adds a new line to avoid having the last comment in a file to be just before the
        // first comment in the imported file, resulting in a single comment block and messing
        // up the LuaDoc generation.
        fileContent += '\n';

        // replaces the file content import line with the file contents
        this.fileContent = this.fileContent.replace(`-- import ${filePath}`, fileContent);
    }

    /**
     * Finds all the import lines in the library file and imports the files.
     */
    importFiles = () => {
        const importFiles = this.listImportFiles();

        importFiles.forEach((filePath) => {
            this.importFile(filePath);
        });
    }

    /**
     * Gets all the import lines inside the library file.
     * 
     * An import line is represented by a comment containing the word import followed by the
     * name of the file to import. Example:
     * 
     * -- import src/Models/Item.lua
     * 
     * @returns the file names without the comment
     */
    listImportFiles = () => {
        const importLines = this.fileContent.match(/-- import .+/g);

        return importLines.map((line) => line.replace('-- import ', ''));
    }

    /**
     * The library version is located anywhere in the main file as a comment.
     * 
     * Example:
     * 
     * -- Library version = '0.0.1'
     * 
     * This method will parse the version from the file content.
     */
    parseVersion = () => {
        if (this.libraryVersion) { return this.libraryVersion; }

        const match = this.fileContent.match(/-- Library version = '(\d+\.\d+\.\d+)'/);

        this.libraryVersion = match ? match[1] : null;

        return this.libraryVersion;
    }

    /**
     * Reads the library file content and stores it in the fileContent property.
     */
    read = () => {
        this.fileContent = fs.readFileSync('../src/stormwind-library.lua', 'utf8');
    }

    /**
     * Wraps the library main function with a check to avoid redefining the library.
     * 
     * Addons using the new library version must replace the instantiation line with the new version.
     * 
     * @returns {string}
     */
    wrapLibraryMainFunction = () => {
        const library = `StormwindLibrary_v${this.getVersionInSnakeCase()}`;

        return `
--- Stormwind Library
-- @module stormwind-library
if (${library}) then return end
        
${library} = {}
${library}.__index = ${library}

function ${library}.new(props)
    local self = setmetatable({}, ${library})
    ${this.fileContent}
    return self
end`;
    }

    /**
     * Writes the built library file to the dist directory.
     * 
     * @param {*} content 
     */
    write = () => {
        const distFolderPath = '../dist';
        
        if (! fs.existsSync(distFolderPath)) {
            fs.mkdirSync(distFolderPath);
        }

        fs.writeFileSync(`${distFolderPath}/stormwind-library.lua`, this.fileContent, 'utf8');
    }
}

// Fire the build process!
new StormwindLibrary().build();