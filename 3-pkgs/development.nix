# Development Tools Module
# AI tools, API tools, VCS, and terminal development
# PERMISSIVE-ONLY: MIT, BSD, Apache-2.0, ISC, Unlicense
# NO GPL/AGPL/CDDL/MPL/EPL/copyleft contamination

{ pkgs, ... }:

{
  home.packages = with pkgs; [

    bruno # MIT - API client (Postman alternative)
    llm # Apache-2.0 - Universal LLM CLI (simonw)

    # Languages & Runtimes
    python3 # PSF - Python programming language
    julia # MIT - High-performance programming language

    # Editors
    ee # Artistic License - Terminal text editor
    blink # ISC - Terminal text editor with IDE features debgger

    # Version Control (permissive licenses only)
    jujutsu # BSD-2-Clause - Modern Git alternative
    fossil # BSD-2-Clause - Self-hosted DVCS

    # Game server framework - MIT license
    # nakama                 # MIT - Scalable game server (requires CockroachDB/PostgreSQL)
  ];
}
