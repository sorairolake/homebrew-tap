# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Favico < Formula
  desc "Utility for creating favicons"
  homepage "https://sorairolake.github.io/favico/"
  url "https://github.com/sorairolake/favico/archive/refs/tags/v0.1.11.tar.gz"
  sha256 "232e9fa642f3d3183c24c45a717e04ab286a06c874de929080b11035d93a6ac8"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/favico.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/favico-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/favico --generate-completion bash > favico.bash"
    system "#{bin}/favico --generate-completion fish > favico.fish"
    system "#{bin}/favico --generate-completion zsh > _favico"
    bash_completion.install "favico.bash"
    fish_completion.install "favico.fish"
    zsh_completion.install "_favico"
  end

  test do
    system "#{bin}/favico", "-V"
  end
end
