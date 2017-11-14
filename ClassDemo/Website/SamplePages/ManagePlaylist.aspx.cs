using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using ChinookSystem.BLL;
using Chinook.Data.POCOs;

#endregion
public partial class SamplePages_ManagePlaylist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Request.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        else
        {
            TracksSelectionList.DataSource = null;
        }
    }

    protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
    {
        MessageUserControl.HandleDataBoundException(e);
    }

    protected void Page_PreRenderComplete(object sender, EventArgs e)
    {
        //PreRenderComplete occurs just after databinding page events
        //load a pointer to point to your DataPager control
        DataPager thePager = TracksSelectionList.FindControl("DataPager1") as DataPager;
        if (thePager != null)
        {
            //this code will check the StartRowIndex to see if it is greater that the
            //total count of the collection
            if (thePager.StartRowIndex > thePager.TotalRowCount)
            {
                thePager.SetPageProperties(0, thePager.MaximumRows, true);
            }
        }
    }

    protected void ArtistFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Artist";
        SearchArgID.Text = ArtistDDL.SelectedValue;
        //refresh the track list display
        TrackSelectionListODS.DataBind();
    }

    protected void MediaTypeFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Media";
        SearchArgID.Text = MediaTypeDDL.SelectedValue;
        //refresh the track list display
        TrackSelectionListODS.DataBind();
    }

    protected void GenreFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Genre";
        SearchArgID.Text = GenreDDL.SelectedValue;
        //refresh the track list display
        TrackSelectionListODS.DataBind();
    }

    protected void AlbumFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        TracksBy.Text = "Album";
        SearchArgID.Text = AlbumDDL.SelectedValue;
        //refresh the track list display
        TrackSelectionListODS.DataBind();
    }

    protected void PlayListFetch_Click(object sender, EventArgs e)
    {
        //code to go here
        //standard query lookup
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            //able to display a message to the user via messageUserControl
            // using .showInfo()
            MessageUserControl.ShowInfo("Warning", "Playlist name cannot be empty");
        }
        else
        {
            //obtain the username from the security identity class
            string username = User.Identity.Name;

            //the MessageUserControl has embedded in its code the try/catch logic
            //you do not need to code your own try catch
            MessageUserControl.TryRun(() =>
            {
                //code to be run under the "watchful" eyes of the user control
                //this is the try{your code} of ther try/catch
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> info = sysmgr.List_TracksForPlaylist(PlaylistName.Text, username);
                PlayList.DataSource = info;
                PlayList.DataBind();
            });
        }
    }

    protected void TracksSelectionList_ItemCommand(object sender,
        ListViewCommandEventArgs e)
    {
        if (string.IsNullOrEmpty(PlaylistName.Text))
        {
            //able to display a message to the user via messageUserControl
            // using .showInfo()
            MessageUserControl.ShowInfo("Warning", "Playlist name cannot be empty");
        }
        else
        {
            string username = User.Identity.Name;

            //where does track Id come from
            // ListViewCommandEventArgs e contains the parameter values for this event
            // CommandArguement
            //CommandArguement is an object
            int trackId = int.Parse(e.CommandArgument.ToString());
            //send your collection of parameter values to the bll for processing
            MessageUserControl.TryRun(() =>
            {
                //code to be run under the "watchful" eyes of the user control
                //this is the try{your code} of ther try/catch
                PlaylistTracksController sysmgr = new PlaylistTracksController();
                List<UserPlaylistTrack> info = sysmgr.Add_TrackToPLaylist(PlaylistName.Text, username, trackId);
                PlayList.DataSource = info;
                PlayList.DataBind();
            }, "Success", "Your track has been added to your playlist.");
        }
    }

    protected void MoveUp_Click(object sender, EventArgs e)
    {
        //code to go here
    }

    protected void MoveDown_Click(object sender, EventArgs e)
    {
        //code to go here
    }
    protected void MoveTrack(int trackid, int tracknumber, string direction)
    {
        //code to go here
    }
    protected void DeleteTrack_Click(object sender, EventArgs e)
    {
        //code to go here
    }
}
