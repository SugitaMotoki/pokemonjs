{
  const { makeESTree, unicode2string, removeBlank, print } = require("../grammar/helper");
}

/**
 * start
 * 最初に必ずアルセウスを書く必要がある
 */
start
  = _ arceus:Arceus _ body:Statements? _ {
    return makeESTree.program(body || []);
  };

/**
 * Statements
 * n個のStatement
 */
Statements
  = head:Statement tailsWithBlank:(_ Statement)* {
    const tails = removeBlank(tailsWithBlank);
    return [head, ...tails]
  }

/**
 * Statement
 * 文
 */
Statement
  = Declaration
  / Assignment
  / Expression
  / Choice
  / Loops
  / Function
  ;

/**
 * 宣言
 */
Declaration
  = VariableDeclaration
  // / FunctionDeclaration

/**
 * 変数宣言
 */
VariableDeclaration
  = Ditto _ constFlag:ConstFlag? _ identifier:Identifier _ expression:Expression {
    const isConst = constFlag ? true : false;
    return makeESTree.variableDeclaration(isConst, identifier, expression)
  }

/**
 * 変数がconstであることを示す
 */
ConstFlag
  = Klefki;

/**
 * Assignment
 * 代入
 */
Assignment
  = Rotom _ identifier:Identifier _ expression:Expression {
    return makeESTree.assignment(identifier, expression);
  }

/**
 * Expression
 * 計算式
 */
Expression "Expression"
  = multipliedExpression:MultipliedExpression {
    return makeESTree.expression(multipliedExpression);
  }
  / binaryExpression:BinaryExpression {
    return makeESTree.expression(binaryExpression);
  }
  / singleExpression:SingleExpression {
    return makeESTree.expression(singleExpression);
  }

SingleExpression
  = Identifier
  / Literal

MultipliedExpression
  = left:BinaryExpression _ operator:BinaryOperator _ right:SingleExpression {
    return makeESTree.binaryExpression(left, operator, right);
  }

/**
 * BinaryExpression
 * 二項演算式
 */
BinaryExpression
  = left:SingleExpression _ operator:BinaryOperator _ right:SingleExpression {
    return makeESTree.binaryExpression(left, operator, right);
  }

/**
 * Choice
 * 条件分岐
 */
Choice
  = Slowpoke conditionsWithBlank:(_ Condition)+ _ alternate:Alternate? _ Pikachu {
    const conditions = removeBlank(conditionsWithBlank);
    return makeESTree.choice(conditions, alternate, 0);
  }
/**
 * else if のようなもの
 */
Condition
  = Slowbro _ test:Expression _ statements:Statements {
    return { test, statements };
  }
/**
 * else のようなもの
 */
Alternate
  = Slowking _ statements:Statements {
    return statements;
  }

/**
 * Loops
 * 反復
 */
Loops
  = Celebi _ test:Expression _ statements:Statements _ Pikachu {
    return makeESTree.loops(test, statements);
  }

/**
 * Function
 * 関数呼び出し
 */
Function
  = Print
  // / なんか色々な関数
  ;

/**
 * Print
 * ペラップのあとにLiteralを置いてLiteralの内容を出力する
 */
Print
  = Chatot _ expression:Expression {
    return makeESTree.consoleLog(expression);
  };

/**
 * Literal
 * Number・String・Boolean
 */
Literal
  = number:Number { return makeESTree.literal(number) }
  / string:String { return makeESTree.literal(string) }
  / boolean:Boolean { return makeESTree.literal(boolean) }

/**
 * BinaryOperator
 * 二項演算子
 */
BinaryOperator
  = ComparisonOperator
  / ArithmeticOperator
  // / LogicalOperator

/**
 * ArithmeticOperator
 * 算術演算子
 */
ArithmeticOperator
  = Plus // "+"
  / Minus // "-"
  / Multiplied // "*"
  / Divided // "/"
  / Mod // "%"

/**
 * ComparisonOperator
 * 比較演算子
 */
ComparisonOperator
  = Eq // "==="
  / Ne // "!=="
  / Ge // ">="
  / Le // "<="
  / Gt // ">"
  / Lt // "<"

/**
 * Identifier
 */
Identifier
  = identifirePokemon:IdentifierPokemon {
    return makeESTree.identifier(identifirePokemon);
  }

/**
 * Number
 * ドンメル（Numel）のあとに数値ポケモンをn匹置いてn桁の10進数を表現する
 */
Number
  = Numel charactersWithBlank:(_ Dec)* {
    const characters = removeBlank(charactersWithBlank);
    return parseInt(characters.join(""), 10);
  };

/**
 * String
 * アンノーン（Unown）のあとにUnicodeをn個置く
 */
String
  = Unown charactersWithBlank:(_ Unicode)* {
    const characters = removeBlank(charactersWithBlank);
    return characters.join("");
  };

Boolean
  = False
  / True;

/**
 * Unicode
 * ユニラン（Solosis）のあとに数値ポケモンを4匹置いて4桁の16進数を表現する
 */
Unicode
  = Solosis _ h1:Hex _ h2:Hex _ h3:Hex _ h4:Hex {
    return unicode2string(h1 + h2 + h3 + h4);
  }

/** 数字 **/

/**
 * Hex
 * ビクティニ～スピアーを0～15とする16進数
 * リザードはリザードンに包含されるため順番を入れ替える必要がある
 */
Hex
  = Hex0 
  / Hex1 
  / Hex2 
  / Hex3 
  / Hex4
  / Hex6 // リザードン
  / Hex5 // リザード
  / Hex7 
  / Hex8 
  / Hex9 
  / HexA 
  / HexB 
  / HexC 
  / HexD 
  / HexE 
  / HexF;

Hex0 = Victini { return "0" };
Hex1 = Bulbasaur { return "1" };
Hex2 = Ivysaur { return "2" };
Hex3 = Venusaur { return "3" };
Hex4 = Charmander { return "4" };
Hex5 = Charmeleon { return "5" };
Hex6 = Charizard { return "6" };
Hex7 = Squirtle { return "7" };
Hex8 = Wartortle { return "8" };
Hex9 = Blastoise { return "9" };
HexA = Caterpie { return "A" };
HexB = Metapod { return "B" };
HexC = Butterfree { return "C" };
HexD = Weedle { return "D" };
HexE = Kakuna { return "E" };
HexF = Beedrill { return "F" };

/**
 * Dec
 * ビクティニ～カメックスを0～9とする10進数
 * リザードはリザードンに包含されるため順番を入れ替える必要がある
 */
Dec
  = Dec0 
  / Dec1 
  / Dec2 
  / Dec3 
  / Dec4
  / Dec6 // リザードン
  / Dec5 // リザード
  / Dec7 
  / Dec8 
  / Dec9 

Dec0 = Victini { return 0 };
Dec1 = Bulbasaur { return 1 };
Dec2 = Ivysaur { return 2 };
Dec3 = Venusaur { return 3 };
Dec4 = Charmander { return 4 };
Dec5 = Charmeleon { return 5 };
Dec6 = Charizard { return 6 };
Dec7 = Squirtle { return 7 };
Dec8 = Wartortle { return 8 };
Dec9 = Blastoise { return 9 };

False = Mewtwo { return false };
True = Mew { return true };

Plus = Plusle { return "+" };
Minus = Minun { return "-" };
Multiplied = Metagross { return "*" };
Divided = Gallade { return "/" };
Mod = Aurorus { return "%" };

Eq = Hitmontop { return "===" };
Ne = Tyrogue { return "!==" };
Ge = Hitmonchan _ Baltoy { return ">=" };
Le = Hitmonlee _ Baltoy { return "<=" };
Gt = Hitmonchan { return ">" };
Lt = Hitmonlee { return "<" };

/** SKIP **/

_ "skip"
  = (Whitespace / LineTerminatorSequence)*;

Whitespace "whitespace"
  = "\t"
  / "\v"
  / "\f"
  / " "
  / "\u00A0"
  / "\uFEFF"
  / Zs;

// Separator, Space
Zs = [\u0020\u00A0\u1680\u2000-\u200A\u202F\u205F\u3000];

LineTerminatorSequence "end of line"
  = "\n"
  / "\r\n"
  / "\r"
  / "\u2028"
  / "\u2029";

/** ポケモン **/

IdentifierPokemon
  = Pidgey { return "pidgey" }
  / Pidgeotto { return "pidgeotto" }
  / Pidgeot { return "pidgeot" }
  / Rattata { return "rattata" }
  / Raticate { return "raticate" }
  / Spearow { return "spearow" }
  / Fearow { return "fearow" }
  / Ekans { return "ekans" }
  / Arbok { return "arbok" }
  / Raichu { return "raichu" }
  / Sandshrew { return "sandshrew" }
  / Sandslash { return "sandslash" }
  / NidoranF { return "nidoran♀" }
  / Nidorina { return "nidorina" }
  / Nidoqueen { return "nidoqueen" }
  / NidoranM { return "nidoran♂" }
  / Nidorino { return "nidorino" }
  / Nidoking { return "nidoking" }
  / Clefairy { return "clefairy" }
  / Clefable { return "clefable" }
  / Vulpix { return "vulpix" }
  / Ninetales { return "ninetales" }
  / Jigglypuff { return "jigglypuff" }
  / Wigglytuff { return "wigglytuff" }
  / Zubat { return "zubat" }
  / Golbat { return "golbat" }
  / Oddish { return "oddish" }
  / Gloom { return "gloom" }
  / Vileplume { return "vileplume" }
  / Paras { return "paras" }
  / Parasect { return "parasect" }
  / Venonat { return "venonat" }
  / Venomoth { return "venomoth" }
  / Diglett { return "diglett" }
  / Dugtrio { return "dugtrio" }
  / Meowth { return "meowth" }
  / Persian { return "persian" }
  / Psyduck { return "psyduck" }
  / Golduck { return "golduck" }
  / Mankey { return "mankey" }
  / Primeape { return "primeape" }
  / Growlithe { return "growlithe" }
  / Arcanine { return "arcanine" }

Bulbasaur "Bulbasaur"
  = "bulbsaur" / "Bulbasaur" / "フシギダネ" / "0001";
Ivysaur "Ivysaur"
  = "ivysaur" / "Ivysaur" / "フシギソウ" / "0002";
Venusaur "Venusaur"
  = "venusaur" / "Venusaur" / "フシギバナ" / "0003";
Charmander "Charmander"
  = "charmander" / "Charmander" / "ヒトカゲ" / "0004";
Charmeleon "Charmeleon"
  = "charmeleon" / "Charmeleon" / "リザード" / "0005";
Charizard "Charizard"
  = "charizard" / "Charizard" / "リザードン" / "0006";
Squirtle "Squirtle"
  = "squirtle" / "Squirtle" / "ゼニガメ" / "0007";
Wartortle "Wartortle"
  = "wartortle" / "Wartortle" / "カメール" / "0008";
Blastoise "Blastoise"
  = "blastoise" / "Blastoise" / "カメックス" / "0009";
Caterpie "Caterpie"
  = "caterpie" / "Caterpie" / "キャタピー" / "0010";
Metapod "Metapod"
  = "metapod" / "Metapod" / "トランセル" / "0011";
Butterfree "Butterfree"
  = "butterfree" / "Butterfree" / "バタフリー" / "0012";
Weedle "Weedle"
  = "weedle" / "Weedle" / "ビードル" / "0013";
Kakuna "Kakuna"
  = "kakuna" / "Kakuna" / "コクーン" / "0014";
Beedrill "Beedrill"
  = "beedrill" / "Beedrill" / "スピアー" / "0015";
Pidgey
  = "pidgey" / "Pidgey" / "ポッポ" / "0016";
Pidgeotto
  = "pidgeotto" / "Pidgeotto" / "ピジョン" / "0017";
Pidgeot
  = "pidgeot" / "Pidgeot" / "ピジョット" / "0018";
Rattata
  = "rattata" / "Rattata" / "コラッタ" / "0019";
Raticate
  = "raticate" / "Raticate" / "ラッタ" / "0020";
Spearow
  = "spearow" / "Spearow" / "オニスズメ" / "0021";
Fearow
  = "fearow" / "Fearow" / "オニドリル" / "0022";
Ekans
  = "ekans" / "Ekans" / "アーボ" / "0023";
Arbok
  = "arbok" / "Arbok" / "アーボック" / "0024";
Pikachu "Pikachu"
  = "pikachu" / "Pikachu" / "ピカチュウ" / "0025";
Raichu
  = "raichu" / "Raichu" / "ライチュウ" / "0026";
Sandshrew
  = "sandshrew" / "Sandshrew" / "サンド" / "0027";
Sandslash
  = "sandslash" / "Sandslash" / "サンドパン" / "0028";
NidoranF
  = "nidoran♀" / "Nidoran♀" / "ニドラン♀" / "0029";
Nidorina
  = "nidorina" / "Nidorina" / "ニドリーナ" / "0030";
Nidoqueen
  = "nidoqueen" / "Nidoqueen" / "ニドクイン" / "0031";
NidoranM
  = "nidoran♂" / "Nidoran♂" / "ニドラン♂" / "0032";
Nidorino
  = "nidorino" / "Nidorino" / "ニドリーノ" / "0033";
Nidoking
  = "nidoking" / "Nidoking" / "ニドキング" / "0034";
Clefairy
  = "clefairy" / "Clefairy" / "ピッピ" / "0035";
Clefable
  = "clefable" / "Clefable" / "ピクシー" / "0036";
Vulpix
  = "vulpix" / "Vulpix" / "ロコン" / "0037";
Ninetales
  = "ninetales" / "Ninetales" / "キュウコン" / "0038";
Jigglypuff
  = "jigglypuff" / "Jigglypuff" / "プリン" / "0039";
Wigglytuff
  = "wigglytuff" / "Wigglytuff" / "プクリン" / "0040";
Zubat
  = "zubat" / "Zubat" / "ズバット" / "0041";
Golbat
  = "golbat" / "Golbat" / "ゴルバット" / "0042";
Oddish
  = "oddish" / "Oddish" / "ナゾノクサ" / "0043";
Gloom
  = "gloom" / "Gloom" / "クサイハナ" / "0044";
Vileplume
  = "vileplume" / "Vileplume" / "ラフレシア" / "0045";
Paras
  = "paras" / "Paras" / "パラス" / "0046";
Parasect
  = "parasect" / "Parasect" / "パラセクト" / "0047";
Venonat
  = "venonat" / "Venonat" / "コンパン" / "0048";
Venomoth
  = "venomoth" / "Venomoth" / "モルフォン" / "0049";
Diglett
  = "diglett" / "Diglett" / "ディグダ" / "0050";
Dugtrio
  = "dugtrio" / "Dugtrio" / "ダグトリオ" / "0051"
Meowth
  = "meowth" / "Meowth" / "ニャース" / "0052";
Persian
  = "persian" / "Persian" / "ペルシアン" / "0053";
Psyduck
  = "psyduck" / "Psyduck" / "コダック" / "0054";
Golduck
  = "golduck" / "Golduck" / "ゴルダック" / "0055";
Mankey
  = "mankey" / "Mankey" / "マンキー" / "0056";
Primeape
  = "primeape" / "Primeape" / "オコリザル" / "0057";
Growlithe
  = "growlithe" / "Growlithe" / "ガーディ" / "0058";
Arcanine
  = "arcanine" / "Arcanine" / "ウインディ" / "0059";
Slowpoke
  = "slowpoke" / "Slowpoke" / "ヤドン" / "0079";
Slowbro
  = "slowbro" / "Slowbro" / "ヤドラン" / "0080";
Hitmonlee
  = "hitmonlee" / "Hitmonlee" / "サワムラー" / "0106";
Hitmonchan
  = "hitmonchan" / "Hitmonchan" / "エビワラー" / "0107";
Ditto
  = "ditto" / "Ditto" / "メタモン" / "0132";
Mewtwo
  = "mewtwo" / "Mewtwo" / "ミュウツー" / "0150";
Mew
  = "mew" / "Mew" / "ミュウ" / "0151";
Slowking
  = "slowking" / "Slowking" / "ヤドキング" / "0199";
Numel "Numel"
  = "numel" / "Numel" / "ドンメル" / "0322";
Unown "Unown"
  = "unown" / "Unown" / "アンノーン" / "0201";
Tyrogue
  = "tyrogue" / "Tyrogue" / "バルキー" / "0236";
Hitmontop
  = "hitmontop" / "Hitmontop" / "カポエラー" / "0237";
Celebi
  = "celebi" / "Celebi" / "セレビィ" / "0251";
Plusle
  = "plusle" / "Plusle" / "プラスル" / "0311";
Minun
  = "minun" / "Minun" / "マイナン" / "0312";
Baltoy
  = "baltoy" / "Baltoy" / "ヤジロン" / "0343";
Metagross
  = "metagross" / "Metagross" / "メタグロス" / "0376";
Chatot "Chatot"
  = "chatot" / "Chatot" / "ペラップ" / "0441";
Gallade
  = "gallade" / "Gallade" / "エルレイド" / "0475";
Rotom
  = "rotom" / "Rotom" / "ロトム" / "0479";
Arceus "Arceus"
  = "arceus" / "Arceus" / "アルセウス" / "0493";
Victini "Victini"
  = "victini" / "Victini" / "ビクティニ" / "0494";
Solosis "Solosis"
  = "solosis" / "Solosis" / "ユニラン" / "0557";
Aurorus
  = "aurorus" / "Aurorus" / "アマルルガ" / "0699";
Klefki
  = "klefki" / "Klefki" / "クレッフィ" / "0707";
