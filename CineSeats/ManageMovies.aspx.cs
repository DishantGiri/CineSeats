using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using CineSeats.Data;
using Oracle.ManagedDataAccess.Client;

namespace CineSeats
{
    public partial class ManageMovies : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadMovies();
            }
        }

        private void LoadMovies()
        {
            try
            {
                string query = "SELECT * FROM MOVIE ORDER BY MOVIE_ID DESC";
                gvMovies.DataSource = DatabaseHelper.ExecuteQuery(query);
                gvMovies.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime releaseDate = DateTime.Parse(txtReleaseDate.Text);
                if (string.IsNullOrEmpty(hfMovieId.Value))
                {
                    string query = "INSERT INTO MOVIE (MOVIE_ID, TITLE, DURATION, LANGUAGE, GENRE, RELEASE_DATE) VALUES (MOVIE_ID_SEQ.NEXTVAL, :title, :dur, :lang, :genre, :relDate)";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("title", txtTitle.Text),
                        new OracleParameter("dur", txtDuration.Text),
                        new OracleParameter("lang", txtLanguage.Text),
                        new OracleParameter("genre", txtGenre.Text),
                        new OracleParameter("relDate", releaseDate)
                    });
                }
                else
                {
                    string query = "UPDATE MOVIE SET TITLE = :title, DURATION = :dur, LANGUAGE = :lang, GENRE = :genre, RELEASE_DATE = :relDate WHERE MOVIE_ID = :id";
                    DatabaseHelper.ExecuteNonQuery(query, new OracleParameter[] {
                        new OracleParameter("title", txtTitle.Text),
                        new OracleParameter("dur", txtDuration.Text),
                        new OracleParameter("lang", txtLanguage.Text),
                        new OracleParameter("genre", txtGenre.Text),
                        new OracleParameter("relDate", releaseDate),
                        new OracleParameter("id", hfMovieId.Value)
                    });
                }
                ClearForm();
                LoadMovies();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void gvMovies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EditMovie")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                DataTable dt = DatabaseHelper.ExecuteQuery("SELECT * FROM MOVIE WHERE MOVIE_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                if (dt.Rows.Count > 0)
                {
                    DataRow row = dt.Rows[0];
                    hfMovieId.Value = row["MOVIE_ID"].ToString();
                    txtTitle.Text = row["TITLE"].ToString();
                    txtDuration.Text = row["DURATION"].ToString();
                    txtLanguage.Text = row["LANGUAGE"].ToString();
                    txtGenre.Text = row["GENRE"].ToString();
                    txtReleaseDate.Text = Convert.ToDateTime(row["RELEASE_DATE"]).ToString("yyyy-MM-dd");
                    btnSave.Text = "Update Movie";
                }
            }
        }

        protected void gvMovies_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvMovies.DataKeys[e.RowIndex].Value);
                DatabaseHelper.ExecuteNonQuery("DELETE FROM MOVIE WHERE MOVIE_ID = :id", new OracleParameter[] { new OracleParameter("id", id) });
                LoadMovies();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hfMovieId.Value = "";
            txtTitle.Text = "";
            txtDuration.Text = "";
            txtLanguage.Text = "";
            txtGenre.Text = "";
            txtReleaseDate.Text = "";
            btnSave.Text = "Save Movie";
        }
    }
}
