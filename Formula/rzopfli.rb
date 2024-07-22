# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Rzopfli < Formula
  desc "Lossless data compression tool using Zopfli"
  homepage "https://sorairolake.github.io/rzopfli/"
  url "https://github.com/sorairolake/rzopfli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "46435ff368f81f97a2a75bf3851e4c6a0b1faa6af308c79ae203397133723a5f"
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
