# SPDX-FileCopyrightText: 2025 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Ngrv < Formula
  desc "Terminal-based pipe viewer similar to `pv(1)`"
  homepage "https://github.com/sorairolake/ngrv"
  url "https://github.com/sorairolake/ngrv/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "a3561a747c9b0bd955b18d01efcfc31bb233c3abdea7db95213b01abdb438237"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/ngrv.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    system "asciidoctor", "-b", "manpage", "docs/man/man1/ngrv.1.adoc"
    man1.install "docs/man/man1/ngrv.1"

    system "#{bin}/ngrv --generate-completion bash > ngrv.bash"
    system "#{bin}/ngrv --generate-completion fish > ngrv.fish"
    system "#{bin}/ngrv --generate-completion zsh > _ngrv"
    bash_completion.install "ngrv.bash"
    fish_completion.install "ngrv.fish"
    zsh_completion.install "_ngrv"
  end

  test do
    system "#{bin}/ngrv", "-V"
  end
end
