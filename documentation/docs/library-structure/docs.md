# Documentation

The Stormwind Library documentation is built on top of
[Docusaurus](https://docusaurus.io/) and is hosted on
[GitHub Pages](https://pages.github.com/).

When working on any part of the library, it is important to keep the documentation
up-to-date. This includes updating the documentation for any new features or changes
that are made to the library.

## Adding videos to the documentation

Stormwind Library has a
[YouTube channel](https://www.youtube.com/@stormwindlibrary) where videos are
uploaded to help developers understand how to use the library. Those videos can
be embedded in the documentation by using the `YouTubeEmbed` component.

To add a video to the documentation, follow these steps:

1. Add some imports to the **top of the `.md` file**, before the first `#`
   ```markdown
   import React from 'react';
   import YouTubeEmbed from '@site/src/components/YouTubeEmbed';

   # Document title...
   ```
1. Copy the YouTube video ID from the URL
1. Use the `YouTubeEmbed` component anywhere in the document, like this:
   ```markdown
   <YouTubeEmbed videoId="KRL30brxHLU" />
   ```

## Documentation deployment process

**Single time setup**

Although the following steps need to be done only once, it is important to keep them 
documented in case the library is moved to a new repository or even if it requires some
additional page in the future.

1. Open the `documentation\docusaurus.config.js` file and update the following properties:
   * `url` - `'https://adrianocastro189.github.io'`
   * `baseUrl` - `'/stormwind-library/'`
   * `projectName` - `'stormwind-library'`
   * `organizationName` - `'adrianocastro189'`
1. Open the terminal
1. Navigate to the `documentation` directory and run
   ```shell
   npm run build
   ```
1. Confirm that the `documentation/build` directory was created
1. Install `gh-pages` with the following command:
   ```shell
   npm install --save-dev gh-pages
   ```
1. Open `documentation\package.json` and update the `scripts.deploy` property to:
   ```json
   "deploy": "gh-pages -d build"
   ```
1. Run the deployment command described after these steps
1. Go to [GitHub Pages](https://github.com/adrianocastro189/stormwind-library/settings/pages)
1. Select **Deploy from a branch** and choose the `gh-pages` branch (root directory)
1. Click save

**Deploying the documentation**

1. Open the terminal
1. Navigate to the `documentation` directory and run
   ```shell
   npm run build
   npm run deploy
   ```
1. If running it for the first time, make sure to check if a `gh-pages` branch was created
and pushed to the repository