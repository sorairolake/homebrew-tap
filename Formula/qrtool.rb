# SPDX-FileCopyrightText: None
#
# SPDX-License-Identifier: CC0-1.0

class Qrtool < Formula
  desc "Utility for encoding or decoding QR code"
  homepage "https://sorairolake.github.io/qrtool/"
  url "https://github.com/sorairolake/qrtool/archive/refs/tags/v0.10.10.tar.gz"
  sha256 "2ec55d88d9a71e5ac2c4a38447fbd69cf548ce75f0aabf94251c63d65edd04f2"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/qrtool.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/qrtool-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/qrtool --generate-completion bash > qrtool.bash"
    system "#{bin}/qrtool --generate-completion fish > qrtool.fish"
    system "#{bin}/qrtool --generate-completion zsh > _qrtool"
    bash_completion.install "qrtool.bash"
    fish_completion.install "qrtool.fish"
    zsh_completion.install "_qrtool"
  end

  test do
    system "#{bin}/qrtool", "-V"
  end
end
