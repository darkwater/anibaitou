use std::fmt;
use super::Page;

pub struct Index;

impl fmt::Display for Index {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "Index page")
    }
}
