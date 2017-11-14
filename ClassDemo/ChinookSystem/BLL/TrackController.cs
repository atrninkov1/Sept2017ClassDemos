using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using Chinook.Data.Entities;
using Chinook.Data.DTOs;
using Chinook.Data.POCOs;
using ChinookSystem.DAL;
using System.ComponentModel;
#endregion

namespace ChinookSystem.BLL
{
    [DataObject]
    public class TrackController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<TrackList> List_TracksForPlaylistSelection(string tracksby, int argid)
        {
            using (var context = new ChinookContext())
            {
                List<TrackList> results = null;

                //code to go here
                //determine which lookup needs to be done : tracksby

                results = (from x in context.Tracks
                           orderby x.Name
                           where tracksby == "Artist" ? x.Album.Artist.ArtistId == argid : 
                           tracksby == "MediaType" ? x.MediaType.MediaTypeId == argid :
                           tracksby == "Genre" ? x.Genre.GenreId == argid :
                           x.AlbumId == argid
                           select new TrackList
                           {
                               TrackID = x.TrackId,
                               Name = x.Name,
                               Title = x.Album.Title,
                               MediaName = x.MediaType.Name,
                               GenreName = x.Genre.Name,
                               Composer = x.Composer,
                               Milliseconds = x.Milliseconds,
                               Bytes = x.Bytes,
                               UnitPrice = x.UnitPrice
                           }
                        ).ToList();
                //switch (tracksby)
                //{
                //    case "Artist":
                //        results = (from x in context.Tracks orderby x.Name where x.Album.Artist.ArtistId == argid select new TrackList
                //        {

                //        }
                //        ).ToList();
                //        break;
                //    case "Media":
                //        break;
                //    case "Genre":
                //        break;
                //    default:
                //        break;
                //}
                return results;
            }
        }//eom

       
    }//eoc
}
