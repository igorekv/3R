package
	{
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.utils.ByteArray;
    import flash.events.ProgressEvent;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import FileLoaderEvent;
 
    public class FileLoader extends EventDispatcher
    {
        private var UrlRequest:URLRequest;
        private var UrlLoader:URLLoader;
        private var data:ByteArray;
 
        public function FileLoader()
        {
 
        }
 
        public function read(src:String):void {
            if(src != '') {
                UrlRequest = new URLRequest(src);
                UrlLoader = new URLLoader();
                UrlLoader.dataFormat = URLLoaderDataFormat.BINARY;
                UrlLoader.addEventListener(Event.COMPLETE, onLoadCompleteListener);
                UrlLoader.addEventListener(ProgressEvent.PROGRESS, onProgressListener);
                UrlLoader.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
                UrlLoader.load(UrlRequest);
            } else {
                trace('src is empty');
            }
        }
 
        private function loaderIOErrorHandler(e:IOErrorEvent):void
        {
            UrlLoader.removeEventListener(Event.COMPLETE, onLoadCompleteListener);
            UrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
            UrlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressListener);         
 
            trace("ioErrorHandler: " + e);
        }
 
        private function onLoadCompleteListener(e:Event):void {
            UrlLoader.removeEventListener(Event.COMPLETE, onLoadCompleteListener);
            UrlLoader.removeEventListener(ProgressEvent.PROGRESS, onProgressListener);
            UrlLoader.removeEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
            data = ByteArray(UrlLoader.data);
            dispatchEvent(new FileLoaderEvent(FileLoaderEvent.FILE_COMPLETE));
        }
 
        private function onProgressListener(e:Event):void {
            trace(UrlLoader.bytesLoaded);
        }      
 
        public function getData():ByteArray  {
            return data;
        }
 
    }
 
}