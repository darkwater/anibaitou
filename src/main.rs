use orbtk::prelude::*;

mod pages;

fn main() {
    Application::new()
        .window(|ctx| {
            Window::create()
                .title("OrbTk - minimal example")
                .position((100.0, 100.0))
                .size(420.0, 730.0)
                .child(TextBlock::create().text(format!("{}", pages::Index)).build(ctx))
                .build(ctx)
        })
        .run();
}
