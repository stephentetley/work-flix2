/*
 *  Copyright 2023 Stephen Tetley
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

mod WF.Base.Osgb36 {

    use WF.Base.Osgb36.NGR.{NGR}

    // Two letters and 10 digits
    pub enum NGR(String) with Eq, Order, ToString

    pub def parse(s: String): Option[NGR] = 
        let s1 = String.trim(s);
        let patt = regex"\\p{Alpha}{2}[0-9]{10}";
        if (Regex.isMatch(patt, s1))
            Some(NGR(s1))
        else 
            None


    pub type alias EastNorth = {easting = Int32, northing = Int32}



    pub def toNGR (x: EastNorth): Option[NGR] =
        forM (major <- findMajor(x.easting, x.northing);
            minor   <- findMinor(x.easting, x.northing);
            smallE  <- Some(Int32.toString(Int32.mod(x.easting, 100000)));
            smallN  <- Some(Int32.toString(Int32.mod(x.northing, 100000)));
            s       <- Some(Char.toString(major) + Char.toString(minor) + String.padLeft(5, '0', smallE) + String.padLeft(5, '0', smallN))
        ) yield NGR(s)

    def findMajor(easting: Int32, northing: Int32): Option[Char] =
        match (easting,northing) {
            case (e,n) if e >= 0 and e < 500_000            and n >= 0 and n < 500_000           => Some('S')
            case (e,n) if e >= 500_000 and e < 1_000_000    and n >= 0 and n < 500_000           => Some('T')
            case (e,n) if e >= 0 and e < 500_000            and n >= 500_000 and n < 1_000_000   => Some('N')
            case (e,n) if e >= 500_000 and e < 1_000_000    and n >= 500_000 and n < 1_000_000   => Some('O')
            case (e,n) if e >= 0 and e < 500_000            and n >= 1_000_000 and n < 1_500_000 => Some('H')
            case (e,n) if e >= 500_000 and e < 1_000_000    and n >= 1_000_000 and n < 1_500_000 => Some('J')
            case (_,_) => None
        }


    def findMinor (easting: Int32, northing: Int32): Option[Char] =
        let arr2D = minorGrid();
        let modE = Int32.mod(easting, 500000);
        let modN = Int32.mod(northing, 500000);
        let divE = modE / 100000;
        let divN = modN / 100000;
        if (divE >= 0 and divE < 5 and divN >= 0 and divN < 5) {
            let row1 = Vector.get(divE, arr2D);
            let c = Vector.get(divN, row1);
            Some(c)
        } else
            None
    

    def minorGrid() : Vector[Vector[Char]] = 
        Vector#{ 
            Vector#{ 'V', 'Q', 'L', 'F', 'A' }, 
            Vector#{ 'W', 'R', 'M', 'G', 'B' },
            Vector#{ 'X', 'S', 'N', 'H', 'C' },
            Vector#{ 'Y', 'T', 'O', 'J', 'D' },
            Vector#{ 'Z', 'U', 'P', 'K', 'E' }
        }


    def decodeMajor(c: Char): Option[(Int32, Int32)] = 
        match Char.toUpperCase(c) {
            case 'S'    => Some((0,          0))
            case 'T'    => Some((500_000,    0))
            case 'N'    => Some((0,          500_000))
            case 'O'    => Some((500_000,    500_000))
            case 'H'    => Some((0,          1_000_000))
            case _      => None
        }

    def decodeMinor (c: Char): Option[(Int32, Int32)] = 
        match Char.toUpperCase(c) {
            case 'A'    => Some((0,          400_000))
            case 'B'    => Some((100_000,    400_000))
            case 'C'    => Some((200_000,    400_000))
            case 'D'    => Some((300_000,    400_000))
            case 'E'    => Some((400_000,    400_000))
            case 'F'    => Some((0,          300_000))
            case 'G'    => Some((100_000,    300_000))
            case 'H'    => Some((200_000,    300_000))
            case 'J'    => Some((300_000,    300_000))
            case 'K'    => Some((400_000,    300_000))
            case 'L'    => Some((0,          200_000))
            case 'M'    => Some((100_000,    200_000))
            case 'N'    => Some((200_000,    200_000))
            case 'O'    => Some((300_000,    200_000))
            case 'P'    => Some((400_000,    200_000))
            case 'Q'    => Some((0,          100_000))
            case 'R'    => Some((100_000,    100_000))
            case 'S'    => Some((200_000,    100_000))
            case 'T'    => Some((300_000,    100_000))
            case 'U'    => Some((400_000,    100_000))
            case 'V'    => Some((0,          0))
            case 'W'    => Some((100_000,    0))
            case 'X'    => Some((200_000,    0))
            case 'Y'    => Some((300_000,    0))
            case 'Z'    => Some((400_000,    0))
            case _      => None
        }

    pub def toEastNorth(x: NGR): Option[EastNorth] = 
        let NGR(s) = x;
        let major = String.charAt(0, s);
        let minor = String.charAt(1, s);
        forM(e1         <- String.slice(start = 2, end = 7, s) |> FromString.fromString;
            n1          <- String.slice(start = 7, end = 12, s) |> FromString.fromString;
            (eM, nM)    <- decodeAlpha(major, minor))
        yield { easting = eM + e1, northing = nM + n1 }


    def decodeAlpha(s: Char, t: Char): Option[(Int32, Int32)] =  
        forM(
            (eM, nM) <- decodeMajor(s);
            (em, nm) <- decodeMinor(t))
        yield (eM + em, nM + nm)

    /// This is for Datalog hence failure is signalled by `-1` rather than an Option type.
    pub def eastingfromOsgb36(s: String): Int32 = 
        let step = () -> {
            forM(ngr    <- parse(s);
                en      <- toEastNorth(ngr))
            yield en.easting
        };
        Option.getWithDefault(-1, step())

    /// This is for Datalog hence failure is signalled by `-1` rather than an Option type.
    pub def northingfromOsgb36(s: String): Int32 = 
        let step = () -> {
            forM(ngr    <- parse(s);
                en      <- toEastNorth(ngr))
            yield en.northing
        };
        Option.getWithDefault(-1, step())


}
