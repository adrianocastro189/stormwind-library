const fs = require('fs');

/**
 * Wrapper for the Stormwind Library file located in the src directory.
 */
class StormwindLibrary {
    constructor() {
        this.read();
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
     * Reads the library file content and stores it in the fileContent property.
     */
    read = () => {
        this.fileContent = fs.readFileSync('../src/stormwind-library.lua', 'utf8');
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
        if (this.libraryVersion) {
            return this.libraryVersion;
        }

        const match = this.fileContent.match(/-- Library version = '(\d+\.\d+\.\d+)'/);

        this.libraryVersion = match ? match[1] : null;

        return this.libraryVersion;
    }

    wrapLibraryMainFunction = () => {
        const library = `StormwindLibrary_v${this.getVersionInSnakeCase()}`;

        return `
if (${library}) then return end
        
${library} = {}
${library}.__index = ${library}

function ${library}.new()
    ${this.fileContent}
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

        fs.writeFileSync(`${distFolderPath}/stormwind-library.lua`, this.wrapLibraryMainFunction(), 'utf8');
    }
}

const library = new StormwindLibrary();
library.write();