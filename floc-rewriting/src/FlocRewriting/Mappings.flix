/*
 * Copyright 2024 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



mod FlocRewriting.Mappings {

    pub def siteMapping(): List[(String, String, String, String)] = List#{
        ("SAI00611686", "JUPITER AVENUE/DTK", "JUP01", "Jupiter Avenue DTK"),
        ("SAI00789678", "SATURN ROAD/SCC", "SAT01", "Saturn Road SCC")
    }

    pub def subsysAbbrev(): List[(String, String)] = List#{
        ("KISK", "KIS"),
        ("PUMP", "PMP"),
        ("PUMS", "PMP"),
        ("STAK", "STK"),
        ("TANK", "TNK")
    }


}
