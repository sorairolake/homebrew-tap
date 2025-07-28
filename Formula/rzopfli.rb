# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Rzopfli < Formula
  desc "Lossless data compression tool using Zopfli"
  homepage "https://sorairolake.github.io/rzopfli/"
  url "https://github.com/sorairolake/rzopfli/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "5ccf94507d1d98458015c136fec62bb543fa528fb2af8df37dbf85aafe2ff43a"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/rzopfli.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    system "asciidoctor", "-b", "manpage", "docs/man/man1/rzopfli.1.adoc"
    man1.install "docs/man/man1/rzopfli.1"

    system "#{bin}/rzopfli --generate-completion bash > rzopfli.bash"
    system "#{bin}/rzopfli --generate-completion fish > rzopfli.fish"
    system "#{bin}/rzopfli --generate-completion zsh > _rzopfli"
    bash_completion.install "rzopfli.bash"
    fish_completion.install "rzopfli.fish"
    zsh_completion.install "_rzopfli"
  end

  test do
    system "#{bin}/rzopfli", "-V"
  end
end
