// @ts-check
// `@type` JSDoc annotations allow editor autocompletion and type checking
// (when paired with `@ts-check`).
// There are various equivalent ways to declare your Docusaurus config.
// See: https://docusaurus.io/docs/api/docusaurus-config

import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'Stormwind Library',
  tagline: 'A library developed in Lua to serve as a framework for building World of Warcraft addons.',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://www.stormwindlibrary.com',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'adrianocastro189', // Usually your GitHub org/user name.
  projectName: 'stormwind-library', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/facebook/docusaurus/tree/main/packages/create-docusaurus/templates/shared/',
        },
        gtag: {
          trackingID: 'G-GDGPH5FK71',
          anonymizeIP: true,
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'Stormwind Library',
        logo: {
          alt: 'Stormwind Library',
          src: 'img/logo.png',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'Documentation',
          },
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'LuaDocs',
            href: 'pathname:///lua-docs/index.html',
          },
          {
            label: '❤️ Buy me a coffee',
            to: 'https://github.com/sponsors/adrianocastro189',
          },
          {
            label: 'YouTube',
            to: 'https://www.youtube.com/@stormwindlibrary',
          },
          {
            href: 'https://github.com/adrianocastro189/stormwind-library',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Documentation',
                to: '/docs/intro',
              },
              {
                label: 'LuaDocs',
                to: 'pathname:///lua-docs/index.html',
              },
              {
                label: 'Videos',
                to: 'https://www.youtube.com/@stormwindlibrary',
              },
            ],
          },
          {
            title: 'Addons',
            items: [
              {
                label: 'Memory',
                href: 'https://www.curseforge.com/wow/addons/memory',
              },
              {
                label: 'MultiTargets',
                href: 'https://www.curseforge.com/wow/addons/multitargets',
              },
              {
                label: 'OMG! My Chicken is amazing!',
                href: 'https://www.curseforge.com/wow/addons/omg-my-chicken-is-amazing',
              },
            ],
          },
          {
            title: 'Source',
            items: [
              {
                label: 'Support this project',
                href: 'https://github.com/sponsors/adrianocastro189',
              },
              {
                label: 'View source on GitHub',
                href: 'https://github.com/adrianocastro189/stormwind-library',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Stormwind Library. Built with Docusaurus.`,
      },
      prism: {
        additionalLanguages: ['json', 'lua'],
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
      },
    }),
};

export default config;
