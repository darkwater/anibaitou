use std::fmt;

macro_rules! pages {
    ( $($mod:ident::$struct:ident,)* ) => {
        $(
            mod $mod;
            pub use $mod::$struct;
        )*
    }
}

pages!(
    index::Index,
);

trait Page: fmt::Display {
}
