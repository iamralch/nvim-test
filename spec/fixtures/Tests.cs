namespace Namespace
{
    public class Tests
    {

        [Fact]
        public void Test()
        {
            Assert.Equal(true, false);
        }

        [Fact]
        public async void TestAsync()
        {
            Assert.Equal(true, false);
        }

        [Fact]
        public async Task TestAsyncWithTaskReturn()
        {
            Assert.Equal(true, false);
        }
    }
}