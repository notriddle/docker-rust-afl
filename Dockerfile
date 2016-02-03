# (C) 2015 Michael Howell
# This script is released under the same terms as Rust itself.
FROM buildpack-deps:jessie
ADD build.sh /build.sh
RUN sh /build.sh
ENV PATH /opt/rust/x86_64-unknown-linux-gnu/stage2/bin/:/opt/cargo/target/x86_64-unknown-linux-gnu/release/:/usr/loca/bin/:/usr/bin/:/bin/
ENV LD_LIBRARY_PATH /opt/rust/x86_64-unknown-linux-gnu/stage2/lib/
ENV CXX /usr/bin/clang++ -Wno-c++11-extensions
