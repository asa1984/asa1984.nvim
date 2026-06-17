# JavaScript / TypeScript and its surrounding web ecosystem.
{ pkgs }:
{
  editorTools = with pkgs; [
    vtsls
    biome
    eslint
    prettier
    astro-language-server
    tailwindcss-language-server
    prisma-language-server
    graphql-language-service-cli
    mdx-language-server
  ];
  toolchain = with pkgs; [
    nodejs
    pnpm
    bun
    deno
  ];
}
