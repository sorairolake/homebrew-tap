# SPDX-FileCopyrightText: 2025 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Ngrv < Formula
  desc "Terminal-based pipe viewer similar to `pv(1)`"
  homepage "https://github.com/sorairolake/ngrv"
  url "https://github.com/sorairolake/ngrv/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "e325c6b1ab1dcfb45fd9ddaf87affe878abc4b34cf104d7ba2dbd330c6a5e51e"
  license "GPL-3.0-or-later"
  head "https://github.com/sorairolake/ngrv.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/ngrv-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

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
