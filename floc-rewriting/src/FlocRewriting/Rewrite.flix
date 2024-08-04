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



mod FlocRewriting.Rewrite {

    pub def rewrite(sysHints: List[(String, String, Int32)], 
                    subsysHints: List[(String, String, Int32, String, Int32)]): List[(String, Int32, String, String, String)] = 
        let siteList = FlocRewriting.Mappings.siteMapping();
        let sitesMap = inject siteList into SiteMap;
        let abbrevList = FlocRewriting.Mappings.subsysAbbrev();
        let abbrevs6 = inject abbrevList into SubSysAbbrev;
        let ws1 = FlocRewriting.Worklist.worklist();
        let worklist = inject ws1 into WorkList;
        let kids1 = FlocRewriting.Worklist.childsOf(ws1);
        let descendents = inject kids1 into ChildOf;
        let hints5 = inject sysHints into SysHint;
        let hints6 = inject subsysHints into SubSysHint;
        let rules = level01() <+> level02() <+> level03() <+> level04() <+> level05() <+> level06() <+> flocs();
        let ans = query sitesMap, abbrevs6, worklist, descendents, hints5, hints6, rules select (a, b, c, d, e) from Floc(a, b, c, d, e);
        Vector.toList(ans) |> List.sortBy(match(_, _, floc, _, _) -> floc)


    def flocs(): #{ Floc(String, Int32, String, String, String),
                        Level1(String, String, String),
                        Level2(String, String, String, String),
                        Level3(String, String, String, String),
                        Level4(String, String, String, String),
                        Level5(String, String, String, String),
                        Level6(String, String, String, String)
                         | r} = #{
    
            Floc(aibSaiNum, 1, s4Floc, s4name, "SITE") :- Level1(aibSaiNum, s4Floc, s4name).
            
            Floc(aibSaiNum, 2, siteFloc + s4Floc, s4name, objType) :- 
                Level1(_, siteFloc, _),
                Level2(aibSaiNum, s4Floc, s4name, objType).

            Floc(aibSaiNum, 3, siteFloc + s4Floc, s4name, objType) :- 
                Level1(_, siteFloc, _),
                Level3(aibSaiNum, s4Floc, s4name, objType).

            Floc(aibSaiNum, 4, siteFloc + s4Floc, s4name, objType) :- 
                Level1(_, siteFloc, _),
                Level4(aibSaiNum, s4Floc, s4name, objType).

            Floc(aibSaiNum, 5, siteFloc + s4Floc, s4name, objType) :- 
                Level1(_, siteFloc, _),
                Level5(aibSaiNum, s4Floc, s4name, objType).

            Floc(aibSaiNum, 6, siteFloc + s4Floc, s4name, objType) :- 
                Level1(_, siteFloc, _),
                Level6(aibSaiNum, s4Floc, s4name, objType).
    }

    def level01(): #{ Level1(String, String, String),
                        FlocMapping(String, String), 
                        WorkList(String, String, String, String), 
                        SiteMap(String, String, String, String) | r} = #{
        Level1(aibSaiNum, s4Floc, s4name) :- 
            WorkList(aibSaiNum, _, _, aibType),
            SiteMap(aibSaiNum, _, s4Floc, s4name).


    }

    def level02(): #{ Level2(String, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String), 
                        Level1(String, String, String) | r} = #{
        Level2(aibSaiNum, makeFloc("", "CAA"), "Control and Automation", "CAA") :- 
            WorkList(aibSaiNum, _, _, "CONTROL SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Level1(aibParent, s4Parent, _).

        Level2(aibSaiNum, makeFloc("", "SIF"), "Site Infrastructure", "SIF") :- 
            WorkList(aibSaiNum, _, _, "INSTALLATION SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Level1(aibParent, s4Parent, _).

        Level2(aibSaiNum, makeFloc("", "SMS"), "Site Maint Services", "SMS") :- 
            WorkList(aibSaiNum, _, _, "STATUTORY"),
            ChildOf(aibSaiNum, aibParent),
            Level1(aibParent, s4Parent, _).
        
        Level2(aibSaiNum, makeFloc("", "SSS"), "Site Support Services", "SSS") :- 
            WorkList(aibSaiNum, _, _, "ODOUR CONTROL"),
            ChildOf(aibSaiNum, aibParent),
            Level1(aibParent, s4Parent, _).
        
        Level2(aibSaiNum, makeFloc("", "WTN"), "Waste Water Transmission", "WTN") :- 
            WorkList(aibSaiNum, _, _, "RETENTION"),
            ChildOf(aibSaiNum, aibParent),
            Level1(aibParent, s4Parent, _).

    }

    def level03(): #{ Level3(String, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String),
                        Level2(String, String, String, String) | r} = #{

        Level3(aibSaiNum, makeFloc(s4Parent, "NET"), "Networks", "NET") :- 
            WorkList(aibSaiNum, _, _, "RTS MONITORING"),
            ChildOf(aibSaiNum, aibParent),
            Level2(aibParent, s4Parent, _, _).
        
        Level3(aibSaiNum, makeFloc(s4Parent, "CON"), "Control", "CON") :- 
            WorkList(aibSaiNum, _, _, "MPLC CONTROL"),
            ChildOf(aibSaiNum, aibParent),
            Level2(aibParent, s4Parent, _, _).

        Level3(aibSaiNum,makeFloc(s4Parent, "LFT"), "Site Lifting", "LFT") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            ChildOf(aibSaiNum, aibParent),
            Level2(aibParent, s4Parent, _, _).

        Level3(aibSaiNum, makeFloc(s4Parent, "STM"), "Structure Management", "STM") :- 
            WorkList(aibSaiNum, _, _, "STRUCTURES + SERVICES"),
            ChildOf(aibSaiNum, aibParent),
            Level2(aibSaiNum, s4Parent, _, _).

        Level3(aibSaiNum, makeFloc(s4Parent, "SLM"), "Site Land Management", "SLM") :- 
            WorkList(aibSaiNum, _, _, "ODOUR CONTROL"),
            Level2(aibSaiNum, s4Parent, _, _).

        Level3(aibSaiNum, makeFloc(s4Parent, "WTF"), "Waste Water Transfer", "WTF") :- 
            WorkList(aibSaiNum, _, _, "RETENTION"),
            Level2(aibSaiNum, s4Parent, _, _).

    }

    def level04(): #{ Level4(String, String, String, String), 
                        WorkList(String, String, String, String), 
                        ChildOf(String, String), 
                        Level3(String, String, String, String) | r} = #{

        Level4(aibSaiNum, makeFloc(s4Parent, "TEL"), "Telemetry", "TEL") :- 
            WorkList(aibSaiNum, _, _, "RTS MONITORING"),
            Level3(aibSaiNum, s4Parent, _, _).

        Level4(aibSaiNum, makeFloc(s4Parent, "LOC"), "Logic Controllers", "LOC") :- 
            WorkList(aibSaiNum, _, _, "MPLC CONTROL"),
            Level3(aibSaiNum, s4Parent, _, _).

        Level4(aibSaiNum, makeFloc(s4Parent, "FLT"), "Fixed Lifting", "FLT") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Level3(aibSaiNum, s4Parent, _, _).

        Level4(aibSaiNum, makeFloc(s4Parent, "PLR"), "Portable Lifting", "PLR") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Level3(aibSaiNum, s4Parent, _, _).
        
        Level4(aibSaiNum, makeFloc(s4Parent, "BLG"), "Buildings", "BLG") :- 
            WorkList(aibSaiNum, _, _, "STRUCTURES + SERVICES"),
            Level3(aibSaiNum, s4Parent, _, _).

        Level4(aibSaiNum, makeFloc(s4Parent, "OAC"), "Odour Control", "OAC") :- 
            WorkList(aibSaiNum, _, _, "ODOUR FILTERING"),
            ChildOf(aibSaiNum, aibParent),
            Level3(aibParent, s4Parent, _, _).

        Level4(aibSaiNum, makeFloc(s4Parent, "FLA"), "Flow Attenuation", "FLA") :- 
            WorkList(aibSaiNum, _, _, "RETENTION"),
            Level3(aibSaiNum, s4Parent, _, _).
    }

    def level05(): #{ Level5(String, String, String, String), 
                        WorkList(String, String, String, String),
                        Level4(String, String, String, String), 
                        SysHint(String, String, Int32) | r} = #{

        Level5(aibSaiNum, makeSysFloc(s4Parent, 1), "Fixed Lifting System", "SLFS") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Level4(aibSaiNum, s4Parent, _, "FLT").

        Level5(aibSaiNum, makeSysFloc(s4Parent, 1), "Portable Lifting System", "SLFS") :- 
            WorkList(aibSaiNum, _, _, "LIFTING EQUIPMENT"),
            Level4(aibSaiNum, s4Parent, _, "PLR").

        Level5(aibSaiNum, makeSysFloc(s4Parent, sysIndex), sysName, "SKIO") :- 
            WorkList(aibSaiNum, _, _, "STRUCTURES + SERVICES"),
            Level4(aibSaiNum, s4Parent, _, "BLG"),
            SysHint("BLG", sysName, sysIndex).

        Level5(aibSaiNum, makeSysFloc(s4Parent, sysIndex), sysName, "SODR") :- 
            WorkList(aibSaiNum, _, _, "ODOUR FILTERING"),
            Level4(aibParent, s4Parent, _, "OAC"),
            SysHint("OAC", sysName, sysIndex).

        Level5(aibSaiNum, makeSysFloc(s4Parent, sysIndex), sysName, "STNK") :- 
            WorkList(aibSaiNum, _, _, "RETENTION"),
            Level4(aibParent, s4Parent, _, "FLA"),
            SysHint("FLA", sysName, sysIndex).

    }

    def level06(): #{ Level6(String, String, String, String), 
                        WorkList(String, String, String, String),
                        SubSysAbbrev(String, String),
                        Level4(String, String, String, String), 
                        SubSysHint(String, String, Int32, String, Int32) | r} = #{

        Level6(aibSaiNum, makeSubSysFloc(s4Parent, sysIndex, abbrev, subIndex), subName, typ) :- 
            WorkList(aibSaiNum, _, _, "ODOUR FILTERING"),
            Level4(aibParent, s4Parent, _, "OAC"),
            SubSysHint("OAC", subName, sysIndex, typ, subIndex),
            SubSysAbbrev(typ, abbrev).

        Level6(aibSaiNum, makeSubSysFloc(s4Parent, sysIndex, abbrev, subIndex), subName, typ) :- 
            WorkList(aibSaiNum, _, _, "RETENTION"),
            Level4(aibParent, s4Parent, _, "FLA"),
            SubSysHint("FLA", subName, sysIndex, typ, subIndex),
            SubSysAbbrev(typ, abbrev).

    }

    def makeFloc(parent: String, typ: String): String = 
        parent + "-" + typ

    def makeSysFloc(parent: String, ix: Int32): String = 
        parent + "-SYS" + String.padLeft(2, '0', ToString.toString(ix))

    def makeSubSysFloc(parent: String, sysIx: Int32, subTy: String, subsysIx: Int32): String = 
        parent + "-SYS" + String.padLeft(2, '0', ToString.toString(sysIx)) + "-" + subTy + String.padLeft(2, '0', ToString.toString(subsysIx))

}
