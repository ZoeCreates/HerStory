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
    ]
}
