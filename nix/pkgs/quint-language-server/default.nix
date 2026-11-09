# Quint language server (`@informalsystems/quint-language-server`).
#
# nixpkgs packages only the Quint CLI, so build the server from the Quint
# monorepo with its own package-lock.json. The source is pinned here rather
# than by nvfetcher because `npmDepsHash` has to be bumped together with it.
{
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage (finalAttrs: {
  pname = "quint-language-server";
  version = "0.20.0";

  src = fetchFromGitHub {
    owner = "quint-co";
    repo = "quint";
    tag = "v0.33.1";
    hash = "sha256-F0Yj9e+qTOlj6RzspvkEhilXC6pFHvISBRLgvJmon7I=";
  };

  sourceRoot = "${finalAttrs.src.name}/vscode/quint-vscode/server";

  npmDepsHash = "sha256-Y0p5mYc8JsjnsBz0MQCEZl41NoDQeq/zAwxNJBRA4fI=";

  # `complete.ts` imports the `MarkupContent` type from the client library,
  # which upstream only resolves through the monorepo's parent node_modules.
  # The server's own dependency re-exports the same type.
  postPatch = ''
    substituteInPlace src/complete.ts \
      --replace-fail "from 'vscode-languageclient'" "from 'vscode-languageserver/node'"
  '';

  npmBuildScript = "compile";
})
