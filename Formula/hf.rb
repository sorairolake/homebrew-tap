# SPDX-FileCopyrightText: 2024 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Hf < Formula
  desc "Utility for hidden files and directories"
  homepage "https://sorairolake.github.io/hf/"
  url "https://github.com/sorairolake/hf/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "ca28e904638a35d7d81471c884b9b430de04c778b6e0815f1dc4457698f922ec"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/hf.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/hf-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/hf --generate-completion bash > hf.bash"
    system "#{bin}/hf --generate-completion fish > hf.fish"
    system "#{bin}/hf --generate-completion zsh > _hf"
    bash_completion.install "hf.bash"
    fish_completion.install "hf.fish"
    zsh_completion.install "_hf"
  end

  test do
    system "#{bin}/hf", "-V"
  end
end
