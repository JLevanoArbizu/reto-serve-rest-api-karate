function fn() {
    return {
        getRandomEmail: function() {
            var random = Math.floor(Math.random() * 99999);
            return "user_" + random + "@levanocode.com";
        }
    };
}