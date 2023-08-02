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

mod Rules1 {


    pub def doubleWhitespace(): #{Equipment(Int32, String, String, String), CheckError(String, Int32, String)} = #{
        // No double (or more) whitespace
        CheckError("Equipment with extraneus whitespace", equiId, name) :-
            Equipment(equiId, name, _, _),
            if Regex.isSubmatch(regex"\\p{Space}{2,}", name).
    }


    pub def dispIsDel(): #{Equipment(Int32, String, String, String), CheckError(String, Int32, String)} = #{
        // Names of deleted equipment should end in ` (Del)`.
        CheckError("Equipment with Status=DISP does not have a (DEL) suffix", equiId, name) :-
            Equipment(equiId, name, "DISP", _),
            if not Regex.endsWith(suffix = regex"(?i)\\(Del\\)", name).
    }

    pub def equiOperBelowDel(): #{Equipment(Int32, String, String, String), CheckError(String, Int32, String), SubEquipment(Int32, Int32), IsInactive(Int32)} = #{
        // If parent is "DEL" / "DISP", no child should be "OPER".
        CheckError("Equipment with Status=DISP has OPER subequipment", parentId, name) :-
            Equipment(parentId, name, _, _),
            IsInactive(parentId),
            SubEquipment(parentId, childId),
            Equipment(childId, _, "OPER", _).

        IsInactive(equiId) :- Equipment(equiId, _, "DEL", _). 
        IsInactive(equiId) :- Equipment(equiId, _, "DISP", _). 
    }

}
