(function () {
    "use strict";
    /* page item.Type "Person" "Movie" "Series" "Season" "Episode" "BoxSet" "video-osd" so. */
    const show_pages = ["Movie", "Series", "Episode", "Season", "video-osd"];
    var item;
    document.addEventListener("itemshow", function (e) {
        item = e.detail.item;
        var new_people = [];
        if (showFlag() && item.People) {
            for (let p of item.People) {
                p.PrimaryImageTag && new_people.push(p);
            }
            item.People = new_people;
        }
    });
    document.addEventListener("viewbeforeshow", function (e) {
        if (e.detail.path == "/item" || e.detail.type == "video-osd") {
            if (e.detail.isRestored == false) {
                const mutation = new MutationObserver(function () {
                    item = e.target.controller.currentItem || e.target.controller.videoOsd?.currentItem;
                    if (item) {
                        mutation.disconnect();
                        var new_people = [];
                        if (showFlag() && item.People) {
                            for (let p of item.People) {
                                p.PrimaryImageTag && new_people.push(p);
                            }
                            e.detail.path == "/item" && (e.target.controller.currentItem.People = new_people);
                            e.detail.type == "video-osd" && setTimeout(() => {
                                e.target.controller.videoOsd && (e.target.controller.videoOsd.currentItem.People = new_people);
                                e.target.controller.currentItem && (e.target.controller.currentItem.People = new_people);
                            }, 1000);
                        }
                    }
                })
                mutation.observe(document.body, {
                    childList: true,
                    characterData: true,
                    subtree: true,
                })
            }
        }
    });
    function showFlag() {
        for (let show_page of show_pages) {
            if (item.Type == show_page) {
                return true;
            }
        }
        return false;
    }
})();
