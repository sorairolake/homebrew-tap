# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Hf < Formula
  desc "Utility for hidden files and directories"
  homepage "https://sorairolake.github.io/hf/"
  url "https://github.com/sorairolake/hf/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "a7bf875dedd673fba5bd69418ca197eeaa7c8772ee57601bbbc01bd9e0d3bad1"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/hf.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    system "asciidoctor", "-b", "manpage", "docs/man/man1/*.1.adoc"
    man1.install Dir["docs/man/man1/*.1"]

    system "#{bin}/hf completion bash > hf.bash"
    system "#{bin}/hf completion fish > hf.fish"
    system "#{bin}/hf completion zsh > _hf"
    bash_completion.install "hf.bash"
    fish_completion.install "hf.fish"
    zsh_completion.install "_hf"
  end

  test do
    system "#{bin}/hf", "-V"
  end
end
