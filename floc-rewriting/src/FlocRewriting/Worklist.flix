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



mod FlocRewriting.Worklist {

    pub def worklist(): List[(String, String, String, String)] = List#{
        ("SAI00611686", "JUPITER AVENUE/DTK", "JUPITER AVENUE/DTK", "SITE"),
        ("SAI00644732", "JUPITER AVENUE/DTK/CONTROL SERVICES", "CONTROL SERVICES", "PROCESS_GROUP"),
        ("SAI00644733", "JUPITER AVENUE/DTK/CONTROL SERVICES/RTS MONITORING", "RTS MONITORING", "PROCESS")
    }

    // Facts extracted from WorkList
    pub def childOf(): List[(String, String)] = List#{
        ("SAI00644732", "SAI00611686"),
        ("SAI00644733", "SAI00644732")
    }

}
