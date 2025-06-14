# SPDX-FileCopyrightText: 2025 Shun Sakai
#
# SPDX-License-Identifier: CC0-1.0

class Randgen < Formula
  desc "Generate pseudo-random bytes"
  homepage "https://github.com/sorairolake/randgen"
  url "https://github.com/sorairolake/randgen/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "ef59b83374d550e56ebf755c6d07e318d733e44277af51f3a7f3b84d61915a1c"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/sorairolake/randgen.git", branch: "develop"

  depends_on "asciidoctor" => :build
  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args

    out_dir = Dir["target/release/build/randgen-*/out"].first
    man1.install Dir["#{out_dir}/*.1"]

    system "#{bin}/randgen --generate-completion bash > randgen.bash"
    system "#{bin}/randgen --generate-completion fish > randgen.fish"
    system "#{bin}/randgen --generate-completion zsh > _randgen"
    bash_completion.install "randgen.bash"
    fish_completion.install "randgen.fish"
    zsh_completion.install "_randgen"
  end

  test do
    system "#{bin}/randgen", "-V"
  end
end
