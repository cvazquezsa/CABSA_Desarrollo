[Forma]
Clave=UsuarioNoDeducibleMaximo
Nombre=Máximo No Deducible
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=354
PosicionInicialArriba=335
PosicionInicialAlturaCliente=62
PosicionInicialAncho=316
Comentarios=Info.Mov
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioMovImporteMaximo
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=UsuarioMovImporteMaximo.NoDeducibleMaximo
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=UsuarioMovImporteMaximo.Usuario=<T>{Info.Usuario}<T> AND<BR>UsuarioMovImporteMaximo.Modulo=<T>{Info.Modulo}<T> AND<BR>UsuarioMovImporteMaximo.Mov=<T>{Info.Mov}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Ficha.UsuarioMovImporteMaximo.NoDeducibleMaximo]
Carpeta=Ficha
Clave=UsuarioMovImporteMaximo.NoDeducibleMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
