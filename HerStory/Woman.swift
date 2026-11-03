//
//  Woman.swift
//  HerStory
//

import Foundation

/// "她的故事"：每位女性一份，用作者名和 Quote 对应起来
struct Woman {
    let name: String        // 必须和 Quote.author 完全一致
    let years: String
    let headline: String
    let story: String
    let keyMoment: String
}

enum WomenLibrary {
    /// 根据语录作者找到她的故事；还没写故事的人返回 nil
    static func find(_ author: String) -> Woman? {
        all.first { $0.name == author }
    }

    static let all: [Woman] = [
        Woman(name: "Malala Yousafzai",
              years: "b. 1997",
              headline: "Education activist, youngest Nobel laureate",
              story: "Malala grew up in Pakistan's Swat Valley, where her father ran a school. When the Taliban banned girls from going to school, 11-year-old Malala began writing an anonymous blog for BBC Urdu about life under their rule — and kept speaking out publicly for every girl's right to learn. In 2014, at 17, she became the youngest person ever awarded the Nobel Peace Prize.",
              keyMoment: "On October 9, 2012, a gunman boarded her school bus and shot her. She survived — and nine months later, on her 16th birthday, she stood up to speak at the United Nations."),

        Woman(name: "Ruth Bader Ginsburg",
              years: "1933–2020",
              headline: "U.S. Supreme Court Justice",
              story: "Ruth was one of only nine women in a Harvard Law class of about 500. She finished at Columbia, tied for first in her class — and still no New York law firm would hire her. In the 1970s she co-founded the ACLU's Women's Rights Project and argued six sex-discrimination cases before the Supreme Court, winning five. In 1993 she became the second woman ever to serve on the Court, where she stayed for 27 years.",
              keyMoment: "At a dinner for the few women in her Harvard Law class, the dean asked each of them to explain why she was taking a place that could have gone to a man."),

        Woman(name: "Eleanor Roosevelt",
              years: "1884–1962",
              headline: "First Lady & human rights champion",
              story: "Orphaned by the age of ten and painfully shy as a girl, Eleanor became one of the most outspoken First Ladies in U.S. history. She held press conferences open only to women reporters and wrote a syndicated newspaper column, \"My Day,\" for nearly three decades. After her husband's death, she became a U.S. delegate to the United Nations.",
              keyMoment: "She chaired the UN commission that drafted the Universal Declaration of Human Rights, adopted in 1948 — still the foundation of human rights law today."),

        Woman(name: "Billie Jean King",
              years: "b. 1943",
              headline: "Tennis champion & equality advocate",
              story: "Billie Jean won 39 Grand Slam titles across singles, doubles and mixed doubles. Off the court, she fought just as hard: in 1973 she led the founding of the Women's Tennis Association, and that same year the US Open became the first major tournament to pay women and men equally.",
              keyMoment: "In the 1973 \"Battle of the Sexes,\" she beat Bobby Riggs in straight sets in front of a TV audience estimated at 90 million people."),

        Woman(name: "Michelle Obama",
              years: "b. 1964",
              headline: "Lawyer, author & former First Lady",
              story: "Michelle grew up in a small apartment on Chicago's South Side. She went on to Princeton and Harvard Law School, then worked at a Chicago law firm — where she was assigned to mentor a summer associate named Barack Obama. As First Lady from 2009 to 2017, she launched Let's Move! and Let Girls Learn. Her memoir, Becoming, became one of the best-selling memoirs ever published.",
              keyMoment: "In high school, a college counselor told her she wasn't \"Princeton material.\" She applied anyway — and got in."),

        Woman(name: "Amelia Earhart",
              years: "1897–1937",
              headline: "Aviation pioneer",
              story: "Amelia took her first airplane ride in 1920 and knew right away she had to fly. She worked odd jobs to pay for lessons and saved up to buy her own plane. In 1932 she became the first woman to fly solo across the Atlantic Ocean, and she helped build the Ninety-Nines, an organization for women pilots.",
              keyMoment: "In 1937, while attempting to fly around the world, she disappeared over the Pacific Ocean near Howland Island. She and her navigator were never found."),

        Woman(name: "Rosa Parks",
              years: "1913–2005",
              headline: "Civil rights activist",
              story: "Long before 1955, Rosa was already an activist — she worked as secretary of the NAACP's Montgomery chapter, investigating injustice across Alabama. Her arrest sparked the Montgomery Bus Boycott, which lasted 381 days and ended after the Supreme Court ruled that segregated buses were unconstitutional. She later received the Presidential Medal of Freedom and the Congressional Gold Medal.",
              keyMoment: "On December 1, 1955, after a long day at work as a seamstress, she refused to give up her bus seat to a white passenger — and was arrested."),

        Woman(name: "Marie Curie",
              years: "1867–1934",
              headline: "Physicist & chemist",
              story: "Marie grew up in Warsaw, where women weren't allowed to attend university, so she studied at a secret \"Flying University\" before moving to Paris to study at the Sorbonne. With her husband Pierre, she discovered two new elements, polonium and radium. She was the first woman to win a Nobel Prize (Physics, 1903) and is still the only person to win Nobel Prizes in two different sciences (Chemistry, 1911).",
              keyMoment: "After Pierre died suddenly in 1906, she took over his professorship and became the first woman to teach at the Sorbonne."),

        Woman(name: "Virginia Woolf",
              years: "1882–1941",
              headline: "Novelist & essayist",
              story: "Virginia's brothers went to Cambridge; she was kept at home. So she taught herself, reading her way through her father's library. She went on to write groundbreaking novels like Mrs Dalloway and To the Lighthouse, and with her husband she founded the Hogarth Press to publish work on their own terms.",
              keyMoment: "In 1928 she gave two talks to students at Cambridge's women's colleges. Those talks became A Room of One's Own — one of the most influential feminist essays ever written."),

        Woman(name: "Frida Kahlo",
              years: "1907–1954",
              headline: "Painter",
              story: "Frida had polio as a child, and at 18 a bus crash left her with injuries that caused pain for the rest of her life. While recovering in bed, she started to paint, using a special easel and a mirror above her. Many of her paintings are self-portraits. In 1939, the Louvre bought one of her works, making her the first 20th-century Mexican artist in its collection.",
              keyMoment: "In 1953, doctors ordered her to stay in bed during her first solo show in Mexico. She came anyway — arriving by ambulance and being carried into the gallery on her four-poster bed."),

        Woman(name: "Simone de Beauvoir",
              years: "1908–1986",
              headline: "Philosopher & writer",
              story: "Simone grew up in Paris and fell in love with ideas early. In 1929, at just 21, she passed France's toughest national exam in philosophy, ranking second in the country, and became one of the youngest people ever to pass it. She taught philosophy, wrote novels and essays, and in 1954 won the Prix Goncourt, France's top literary prize, for The Mandarins.",
              keyMoment: "In 1949 she published The Second Sex, arguing that womanhood is shaped by society rather than fixed by nature. The Vatican put it on its list of forbidden books, and it became a founding text of modern feminism."),

        Woman(name: "Sheryl Sandberg",
              years: "b. 1969",
              headline: "Business leader & author",
              story: "Sheryl studied economics at Harvard, then worked at the World Bank and as chief of staff at the U.S. Treasury. She helped build Google's advertising business before joining Facebook in 2008 as chief operating officer, and in 2012 she became the first woman on its board.",
              keyMoment: "In a 2010 TED talk she asked why so few women reach the top of their fields. The talk grew into her book Lean In and the LeanIn.Org community, which helps women support each other at work."),

        Woman(name: "Kamala Harris",
              years: "b. 1964",
              headline: "First woman Vice President of the United States",
              story: "Kamala was raised in Oakland, California, by a mother from India and a father from Jamaica, who took her to civil rights marches as a child. She studied at Howard University and became San Francisco's district attorney, then the first woman elected Attorney General of California, then a U.S. Senator.",
              keyMoment: "On January 20, 2021, she was sworn in as Vice President, the first woman, the first Black American and the first South Asian American to hold the office."),

        Woman(name: "Hillary Rodham Clinton",
              years: "b. 1947",
              headline: "Former U.S. Secretary of State",
              story: "In 1969 Hillary became the first student ever to give the commencement speech at Wellesley College. After Yale Law School she worked as a children's rights lawyer. She went on to become First Lady, a U.S. Senator from New York and Secretary of State. In 2016 she became the first woman nominated for president by a major U.S. party.",
              keyMoment: "In 1995, at the UN's World Conference on Women in Beijing, she declared that women's rights are human rights. The line became a rallying cry for women's movements around the world."),

        Woman(name: "Chimamanda Ngozi Adichie",
              years: "b. 1977",
              headline: "Novelist",
              story: "Chimamanda grew up in the university town of Nsukka, Nigeria. She began studying medicine, then left for the United States at 19 to study communication and writing. Her novels Purple Hibiscus, Half of a Yellow Sun and Americanah have been translated into dozens of languages, and in 2008 she received a MacArthur \"genius\" fellowship.",
              keyMoment: "Her 2012 TEDx talk, We Should All Be Feminists, became a short book given to every 16-year-old in Sweden. Beyoncé sampled it in her 2013 song \"***Flawless.\""),

        Woman(name: "Audre Lorde",
              years: "1934–1992",
              headline: "Poet & civil rights activist",
              story: "Audre was born in Harlem to parents from the Caribbean. She described herself as \"Black, lesbian, mother, warrior, poet,\" and refused to hide any part of who she was. She worked as a librarian and teacher while writing poetry and essays, including the collection Sister Outsider and The Cancer Journals, about her experience with breast cancer.",
              keyMoment: "As a teenager, when her school's literary magazine turned down one of her poems, she sent it to Seventeen magazine instead. They published it."),

        Woman(name: "Toni Morrison",
              years: "1931–2019",
              headline: "Nobel Prize-winning novelist",
              story: "Born Chloe Wofford in Lorain, Ohio, Toni became the first Black woman senior fiction editor at Random House, where she championed Black writers. Her own novels, including Song of Solomon and Beloved, put Black American lives at the center of literature. Beloved won the Pulitzer Prize in 1988.",
              keyMoment: "She wrote her first novel, The Bluest Eye, in the early mornings before her two young sons woke up, while working full-time. In 1993 she became the first Black woman to win the Nobel Prize in Literature."),

        Woman(name: "Shirley Chisholm",
              years: "1924–2005",
              headline: "First Black woman elected to the U.S. Congress",
              story: "Shirley was born in Brooklyn to parents from the Caribbean and spent part of her childhood in Barbados with her grandmother. She worked as an early childhood teacher before entering politics. In 1968, running with the slogan \"Unbought and Unbossed,\" she became the first Black woman elected to Congress, where she fought for education and food programs for poor families.",
              keyMoment: "In 1972 she became the first Black candidate to seek a major party's nomination for president, and the first woman to run for the Democratic nomination."),

        Woman(name: "Emmeline Pankhurst",
              years: "1858–1928",
              headline: "Leader of the British suffragette movement",
              story: "Emmeline grew up in Manchester and went to her first women's suffrage meeting at 14. Frustrated after decades of polite campaigning got nowhere, she founded the Women's Social and Political Union in 1903 with her daughters, under the motto \"Deeds, not words.\" She was arrested again and again, and went on hunger strike in prison.",
              keyMoment: "She died in June 1928. Just weeks later, Britain passed the law giving women the vote on equal terms with men."),

        Woman(name: "Mary Wollstonecraft",
              years: "1759–1797",
              headline: "Philosopher & early feminist",
              story: "Mary grew up with little money and almost no formal schooling, so she taught herself. She opened a school with her sisters, worked as a governess, and then did something rare for a woman of her time: she made her living as a writer in London. In 1792 she published A Vindication of the Rights of Woman, arguing that women only seemed less capable because they were denied an education.",
              keyMoment: "She died days after giving birth to her second daughter, Mary. That baby grew up to become Mary Shelley, the author of Frankenstein."),

        Woman(name: "Charlotte Brontë",
              years: "1816–1855",
              headline: "Novelist",
              story: "Charlotte grew up in a parsonage on the Yorkshire moors. Two of her older sisters died after falling ill at a harsh boarding school, which she later turned into Lowood school in Jane Eyre. With her sisters Emily and Anne, she wrote stories from childhood, and in 1847 all three published novels under the male-sounding pen names Currer, Ellis and Acton Bell.",
              keyMoment: "When rumors spread that the \"Bells\" were one person, Charlotte and Anne traveled to London in 1848 and walked into their publisher's office to prove they were real, and that they were women."),

        Woman(name: "Maya Angelou",
              years: "1928–2014",
              headline: "Poet & memoirist",
              story: "After a traumatic event when she was seven, Maya stopped speaking for nearly five years, spending that time reading and memorizing poetry. At 16 she became San Francisco's first Black woman streetcar conductor. She went on to work as a dancer, singer, journalist and civil rights organizer before writing I Know Why the Caged Bird Sings, the first of seven memoirs.",
              keyMoment: "In 1993 she read her poem \"On the Pulse of Morning\" at President Clinton's inauguration. She was the first poet invited to an inauguration since Robert Frost in 1961."),

        Woman(name: "Simone Biles",
              years: "b. 1997",
              headline: "Most decorated gymnast in history",
              story: "Simone and her younger sister were raised and adopted by their grandparents in Texas. She tried gymnastics at six on a daycare field trip and never stopped. She has won more than 40 Olympic and World Championship medals, and five skills are named after her because she was the first to land them in competition.",
              keyMoment: "At the Tokyo Olympics in 2021, she withdrew from several events to protect her mental health. Three years later, in Paris, she came back and won three more gold medals."),

        Woman(name: "Amanda Gorman",
              years: "b. 1998",
              headline: "Poet",
              story: "Amanda was raised in Los Angeles by a single mother who taught middle school. As a child she had a speech impediment and found it hard to say certain sounds, so she practiced by reciting song lyrics. In 2017, while studying sociology at Harvard, she became the first National Youth Poet Laureate of the United States.",
              keyMoment: "On January 20, 2021, at 22, she read \"The Hill We Climb\" at President Biden's inauguration, the youngest inaugural poet in U.S. history."),

        Woman(name: "Greta Thunberg",
              years: "b. 2003",
              headline: "Climate activist",
              story: "Greta learned about climate change at school in Stockholm and could not understand why adults were not treating it as an emergency. In 2019 she sailed across the Atlantic on a zero-emissions boat to speak at the UN climate summit in New York, and that year Time named her Person of the Year, the youngest ever.",
              keyMoment: "In August 2018, at 15, she sat alone outside the Swedish parliament with a hand-painted sign reading \"School strike for climate.\" Within a year, millions of students around the world had joined her."),

        Woman(name: "Ada Lovelace",
              years: "1815–1852",
              headline: "Mathematician & first computer programmer",
              story: "Ada was the daughter of the poet Lord Byron, whom she never knew. Her mother had her tutored in mathematics and science, which was very unusual for a girl at the time. At 17 she met the inventor Charles Babbage, who was designing a mechanical computer called the Analytical Engine, and they became lifelong collaborators.",
              keyMoment: "In 1843 she translated an article about the Engine and added her own notes, three times longer than the original. They included a method for calculating a sequence of numbers, now seen as the first published computer program."),

        Woman(name: "J.K. Rowling",
              years: "b. 1965",
              headline: "Author",
              story: "The idea for Harry Potter came to Joanne in 1990, on a delayed train from Manchester to London. Over the next few years she wrote the first book as a single mother in Edinburgh, living on very little money. Her publisher asked her to use initials instead of her first name, worried that boys would not read a book by a woman.",
              keyMoment: "The manuscript was rejected by twelve publishers before a small London publisher, Bloomsbury, agreed to print it in 1997."),

        Woman(name: "Oprah Winfrey",
              years: "b. 1954",
              headline: "Media executive & philanthropist",
              story: "Oprah was born in rural Mississippi to a teenage single mother and grew up in poverty. She started reading the news on local radio as a teenager, and at 19 she became a TV news co-anchor in Nashville. The Oprah Winfrey Show ran for 25 years and was the highest-rated talk show in American TV history. She later built her own media company and became one of the world's most influential philanthropists.",
              keyMoment: "In 1984 she took over a struggling morning show in Chicago. Within months it went from last place in the ratings to first."),

        Woman(name: "Grace Hopper",
              years: "1906–1992",
              headline: "Computer scientist & U.S. Navy rear admiral",
              story: "Grace earned a PhD in mathematics from Yale in 1934. During World War II she joined the Navy and became one of the first programmers of the Harvard Mark I computer. She built one of the first compilers, which turns human-readable instructions into machine code, and her work led to COBOL, a programming language still used today.",
              keyMoment: "In 1947 her team found a real moth stuck inside their computer and taped it into the logbook as the \"first actual case of bug being found.\" She loved telling the story, and it helped make \"debugging\" part of everyday language."),

        Woman(name: "Helen Keller",
              years: "1880–1968",
              headline: "Author & disability rights advocate",
              story: "An illness left Helen blind and deaf at 19 months old. When she was six, a teacher named Anne Sullivan arrived and began spelling words into her hand. Helen went on to become the first deafblind person to earn a bachelor's degree, graduating from Radcliffe College in 1904. She wrote 12 books, traveled to dozens of countries and helped found the American Civil Liberties Union.",
              keyMoment: "At a water pump, Anne spelled \"w-a-t-e-r\" into one of Helen's hands while cold water ran over the other. In that moment Helen understood that everything had a name."),

        Woman(name: "Jacinda Ardern",
              years: "b. 1980",
              headline: "Former Prime Minister of New Zealand",
              story: "Jacinda grew up in a small town in New Zealand and worked in a fish and chip shop as a teenager. In 2017, at 37, she became Prime Minister, the youngest woman in the world leading a government at the time. In 2018 she became only the second world leader to give birth while in office, and later brought her baby to the UN General Assembly.",
              keyMoment: "After a terrorist attack on two mosques in Christchurch in 2019, she met the victims' families wearing a headscarf, and within a month her government banned military-style semi-automatic weapons."),

        Woman(name: "Jane Austen",
              years: "1775–1817",
              headline: "Novelist",
              story: "Jane grew up in a busy rectory in Hampshire, England, with seven brothers and sisters, and started writing funny stories as a teenager. Her novels, including Sense and Sensibility, Pride and Prejudice and Emma, were published anonymously, simply credited to \"a Lady.\" Most readers in her lifetime never knew her name.",
              keyMoment: "According to her nephew, she wrote in the family sitting room on small sheets of paper, which she could quickly hide whenever someone came in."),

        Woman(name: "Louisa May Alcott",
              years: "1832–1888",
              headline: "Novelist",
              story: "Louisa grew up in Concord, Massachusetts, in a family that was often short of money. She worked as a seamstress, teacher and servant to help support them, and during the Civil War she served as a nurse in Washington. When a publisher asked her for a book for girls, she drew on her own family and wrote Little Women. It became an instant success.",
              keyMoment: "In 1879 she became the first woman to register to vote in Concord, for the town's school committee election, more than 40 years before women won the national vote."),

        Woman(name: "Mary Shelley",
              years: "1797–1851",
              headline: "Novelist",
              story: "Mary was the daughter of two famous thinkers, Mary Wollstonecraft, who died days after her birth, and the philosopher William Godwin. She grew up reading in her father's library and, at 16, ran away with the poet Percy Bysshe Shelley. Frankenstein, published when she was 20, is often called the first science fiction novel.",
              keyMoment: "In the rainy summer of 1816, near Lake Geneva, the poet Lord Byron challenged his friends to each write a ghost story. Mary's idea became Frankenstein."),

        Woman(name: "Susan B. Anthony",
              years: "1820–1906",
              headline: "Suffragist",
              story: "Susan grew up in a Quaker family that believed women and men were equal. She worked as a teacher, then campaigned against slavery and for women's rights. In 1851 she met Elizabeth Cady Stanton, and the two worked side by side for 50 years, traveling and giving speeches across the country to win women the vote.",
              keyMoment: "In 1872 she voted in the presidential election and was arrested for it. She was fined $100 and refused to pay. The 19th Amendment, which gave women the vote in 1920, was nicknamed the \"Susan B. Anthony Amendment.\""),

        Woman(name: "Elizabeth Cady Stanton",
              years: "1815–1902",
              headline: "Suffragist & abolitionist",
              story: "Elizabeth's father was a judge, and as a girl she read his law books and saw how unfairly the law treated women. She raised seven children while writing speeches and articles for women's rights, many delivered by her friend Susan B. Anthony. Late in life she published The Woman's Bible, challenging religious teachings used to keep women down.",
              keyMoment: "In 1848 she helped organize the Seneca Falls Convention, the first women's rights convention in the U.S. She wrote its Declaration of Sentiments and insisted it demand the right to vote, an idea so radical that even some of her allies opposed it."),

        Woman(name: "Sarah Grimké",
              years: "1792–1873",
              headline: "Abolitionist & women's rights advocate",
              story: "Sarah grew up in a wealthy slaveholding family in South Carolina. She wanted to become a lawyer like her father, but as a girl she was not allowed. She left the South, became a Quaker in Philadelphia, and with her sister Angelina became one of the first women in America to speak in public against slavery. In 1838 she wrote Letters on the Equality of the Sexes.",
              keyMoment: "As a child, she secretly taught an enslaved girl to read, which was against the law in South Carolina. They were caught and punished, but she never forgot it."),

        Woman(name: "Wangari Maathai",
              years: "1940–2011",
              headline: "Environmentalist & Nobel Peace Prize laureate",
              story: "Wangari grew up in rural Kenya and won a scholarship to study in the United States. Back home, she became the first woman in East and Central Africa to earn a doctorate. In 1977 she founded the Green Belt Movement, which has paid women to plant more than 51 million trees, restoring land and giving them an income.",
              keyMoment: "She was arrested and beaten for standing up to the government, including when she stopped a skyscraper from being built in Nairobi's Uhuru Park. In 2004 she became the first African woman to win the Nobel Peace Prize."),

        Woman(name: "Anne Frank",
              years: "1929–1945",
              headline: "Diarist",
              story: "Anne was born in Germany, and her Jewish family fled to Amsterdam when the Nazis came to power. She got a diary for her 13th birthday in 1942. A few weeks later her family went into hiding in a secret annex behind her father's office, where eight people lived for more than two years. The annex was discovered in 1944, and Anne died in a concentration camp at 15. Her father, the only one of them to survive, had her diary published.",
              keyMoment: "In 1944 she heard a radio broadcast asking people to save their diaries to record life under the war. She began rewriting her diary, hoping to publish it one day as a book."),

        Woman(name: "Emily Dickinson",
              years: "1830–1886",
              headline: "Poet",
              story: "Emily lived almost her whole life in her family home in Amherst, Massachusetts. Over time she rarely left the house, but she wrote constantly, nearly 1,800 poems in her own unusual style, with dashes and slant rhymes no one else was using. Fewer than a dozen were published while she was alive, and those were printed anonymously.",
              keyMoment: "After she died, her sister found her poems hidden in her bedroom, many of them hand-sewn into small booklets. They were published over the following decades and changed American poetry."),

        Woman(name: "Emma Watson",
              years: "b. 1990",
              headline: "Actor & UN Women Goodwill Ambassador",
              story: "Emma was cast as Hermione Granger in the Harry Potter films at age nine. While still acting, she studied English literature at Brown University and graduated in 2014. That same year she was named a UN Women Goodwill Ambassador, and she later started a feminist book club, Our Shared Shelf.",
              keyMoment: "In September 2014 she gave a speech at the United Nations launching HeForShe, a campaign inviting men and boys to stand up for gender equality."),
    ]
}
