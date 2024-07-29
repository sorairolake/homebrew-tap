# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Rzopfli < Formula
  desc "Lossless data compression tool using Zopfli"
  homepage "https://sorairolake.github.io/rzopfli/"
  url "https://github.com/sorairolake/rzopfli/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "b6d3bdae8fba5975515d1df4b0bc7e65aa68b243866dcbf695e0463448abd8aa"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/rzopfli.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/rzopfli-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

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
