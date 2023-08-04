@test
def testTemp01(): Bool = 
    Regex.endsWith(suffix = regex"(?i)\\(Del\\)", "Pump-1 (Del)")

@test
def testTemp02(): Bool = 
    Regex.endsWith(suffix = regex"(?i)\\(Del\\)", "Pump-1 (DEL)")

@test
def doubleWhitespace01(): Unit \ IO = 
    let db = inject equiData() into Equipment;
    let answers = 
        query db, WF.Checkers.Rules1.doubleWhitespace() 
        select (msg, equiId, name) from CheckError(msg, equiId, name);
    Vector.forEach(println, answers)

@test
def dispIsDel01(): Unit \ IO = 
    let db = inject equiData() into Equipment;
    let answers = 
        query db, WF.Checkers.Rules1.dispIsDel() 
        select (msg, equiId, name) from CheckError(msg, equiId, name);
    Vector.forEach(println, answers)


def equiData(): List[(Int32, String, String, String)] = 
    List#{(10112, "Pump-1 (Del)",   "ACC01-UST", "DISP")
        , (10113, "Pump-1",         "ACC01-UST", "DISP")
        , (10114, "Pump-1  (Del)",  "ACC01-UST", "DISP")
        , (10115, "Pump-1",         "ACC01-UST", "OPER")
        }