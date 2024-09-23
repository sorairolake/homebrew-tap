# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Favico < Formula
  desc "Utility for creating favicons"
  homepage "https://sorairolake.github.io/favico/"
  url "https://github.com/sorairolake/favico/archive/refs/tags/v0.1.7.tar.gz"
  sha256 "fd01134a23808cf0ddcbd27673bf3a17171b313ba5b005af41f469518bbc9e2f"
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
