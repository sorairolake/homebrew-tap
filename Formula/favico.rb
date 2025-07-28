# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Favico < Formula
  desc "Utility for creating favicons"
  homepage "https://sorairolake.github.io/favico/"
  url "https://github.com/sorairolake/favico/archive/refs/tags/v0.1.12.tar.gz"
  sha256 "20b85ee028ef91a05da04b1b72dae4ad49d5063406221487b7f1a3fdbb017554"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/favico.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    system "asciidoctor", "-b", "manpage", "docs/man/man1/favico.1.adoc"
    man1.install "docs/man/man1/favico.1"

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
