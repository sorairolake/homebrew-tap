# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Gb3sum < Formula
  desc "Print and check BLAKE3 checksums"
  homepage "https://github.com/sorairolake/gb3sum"
  url "https://github.com/sorairolake/gb3sum/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "f3dc68b87b72f5ba4d103cd21b59a22f4f2955bfe5e2ef4c96112b4c704af024"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/gb3sum.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "go" => :build

  def install
    ENV["CGO_ENABLED"] = "0"

    system "go", "build", *std_go_args(ldflags: "-s -w")

    system "asciidoctor", "-b", "manpage", "docs/man/man1/gb3sum.1.adoc"
    man1.install "docs/man/man1/gb3sum.1"

    system "#{bin}/gb3sum --generate-completion bash > gb3sum.bash"
    system "#{bin}/gb3sum --generate-completion fish > gb3sum.fish"
    system "#{bin}/gb3sum --generate-completion zsh > _gb3sum"
    bash_completion.install "gb3sum.bash"
    fish_completion.install "gb3sum.fish"
    zsh_completion.install "_gb3sum"
  end

  test do
    system "#{bin}/gb3sum", "-v"
  end
end
