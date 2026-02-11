# SPDX-FileCopyrightText: 2025 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Randgen < Formula
  desc "Generate pseudo-random bytes"
  homepage "https://github.com/sorairolake/randgen"
  url "https://github.com/sorairolake/randgen/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b53db0da6cd2f2e7c045003d99947440751eb1d4482f34b228bb5cb2f413f801"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/randgen.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    system "asciidoctor", "-b", "manpage", "docs/man/man1/randgen.1.adoc"
    man1.install "docs/man/man1/randgen.1"

    system "#{bin}/randgen --generate-completion bash > randgen.bash"
    system "#{bin}/randgen --generate-completion fish > randgen.fish"
    system "#{bin}/randgen --generate-completion zsh > _randgen"
    bash_completion.install "randgen.bash"
    fish_completion.install "randgen.fish"
    zsh_completion.install "_randgen"
  end

  test do
    system "#{bin}/randgen", "-V"
  end
end
