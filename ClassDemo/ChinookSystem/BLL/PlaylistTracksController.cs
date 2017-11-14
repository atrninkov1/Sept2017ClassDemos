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
    public class PlaylistTracksController
    {
        public List<UserPlaylistTrack> List_TracksForPlaylist(
            string playlistname, string username)
        {
            using (var context = new ChinookContext())
            {
                //what would happen if there is no match for the
                // incoming parameter values
                //we need to ensure that the results have a valid value
                //this value will be the result of a query either a null (not found)
                // or an IEnumerable<T> collection
                //to achieve a valid value encapsulate the query in a
                // .FirstOrDefault()
                var results = (from x in context.Playlists
                               where x.UserName.Equals(username) && x.Name == playlistname
                               select x).FirstOrDefault();
                if (results != null)
                {
                    var theTracks = from x in context.PlaylistTracks
                                    where x.PlaylistId.Equals(results.PlaylistId)
                                    orderby x.TrackNumber
                                    select new UserPlaylistTrack
                                    {
                                        TrackID = x.TrackId,
                                        TrackNumber = x.TrackNumber,
                                        TrackName = x.Track.Name,
                                        Milliseconds = x.Track.Milliseconds,
                                        UnitPrice = x.Track.UnitPrice
                                    };
                    return theTracks.ToList();
                }
                else
                {
                    return null;
                }
            }
        }//eom
        public List<UserPlaylistTrack> Add_TrackToPLaylist(string playlistname, string username, int trackid)
        {
            using (var context = new ChinookContext())
            {
                //code to go here
                //Part One:
                //query to get the playlist id
                var exists = (from x in context.Playlists
                               where x.UserName.Equals(username) && x.Name == playlistname
                               select x).FirstOrDefault();
                //initialize the track number
                int trackNumber = 0;
                //Playlist track instance needed
                PlaylistTrack newTrack = null;
                //determine if a playlist parent instance needs to be created
                if (exists == null)
                {
                    //this is a new playlist
                    //create an instance of playlist to add to PlaylistTable
                    exists = new Playlist();
                    exists.Name = playlistname;
                    exists.UserName = username;
                    exists = context.Playlists.Add(exists);
                    //at this time there is no physical primary key
                    //the pseudo pkey is handled by the HashSet
                    trackNumber = 1;
                }
                else
                {
                    //set track number to be the last track
                    trackNumber = exists.PlaylistTracks.Count + 1;
                    newTrack = exists.PlaylistTracks.SingleOrDefault(x => x.TrackId == trackid);
                    //validation: in our example a track can ONLY exist once on a particular playlist
                    if (newTrack != null)
                    {
                        throw new Exception("Playlist already has requested track.");
                    }
                }
                //part two: Add the PlayListTrack instance
                //use navigation to .Add the new track to PlayListTrack
                newTrack = new PlaylistTrack();
                newTrack.TrackId = trackid;
                newTrack.TrackNumber = trackNumber;
                //NOTE: the pkey for PlaylistId may not yet exist
                //using navigation one can let HashSet handle the PlaylistId pkey value
                exists.PlaylistTracks.Add(newTrack);
                // physically add all data to database commit
                context.SaveChanges();
                return List_TracksForPlaylist(playlistname,username);
            }
        }//eom
        public void MoveTrack(string username, string playlistname, int trackid, int tracknumber, string direction)
        {
            using (var context = new ChinookContext())
            {
                //code to go here 

            }
        }//eom


        public void DeleteTracks(string username, string playlistname, List<int> trackstodelete)
        {
            using (var context = new ChinookContext())
            {
                //code to go here


            }
        }//eom
    }
}
