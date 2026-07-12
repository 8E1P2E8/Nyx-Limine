# System Security & Compliance Module
# Tools with permissive licenses (MIT/Apache/BSD) preferred over GPL
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Container/Supply Chain Security
    grype # Apache-2.0 - Container vulnerability scanner
    syft # Apache-2.0 - SBOM generator
    cosign # Apache-2.0 - Container signing

    # Cryptography
    sops # MPL-2.0 - Secrets management
    age # BSD-3-Clause - File encryption

    # Web Security
    zap # Apache-2.0 - Web app scanner (GUI/API)
    mitmproxy # MIT - Intercepting HTTP/HTTPS proxy
    ffuf # MIT - Fast web fuzzer
    feroxbuster # MIT - Recursive content discovery
    gobuster # Apache-2.0 - Directory/file/DNS enumeration
    nuclei # MIT - Template-based vulnerability scanner
    httpx # MIT - Fast HTTP prober

    # Network Recon
    rustscan # MIT - Async port scanner
    subfinder # MIT - Subdomain discovery
    amass # Apache-2.0 - Attack surface mapping

    # Exploitation
    metasploit # BSD-3-Clause - Penetration testing framework
  ];
}
