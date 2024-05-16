# SPDX-FileCopyrightText: None
#
# SPDX-License-Identifier: CC0-1.0

class Hf < Formula
  desc "Utility for hidden file/directory"
  homepage "https://sorairolake.github.io/hf/"
  url "https://github.com/sorairolake/hf/archive/refs/tags/v0.3.4.tar.gz"
  sha256 "53ba4d7ba5f4ddc2b4b7f28989f724a50bd7d06757296b1ea581f6d24ad71c78"
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
