[Forma]
Clave=NominaPremioSucAlcance
Nombre=Premios Sucursal
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
CarpetaPrincipal=Lista
ListaAcciones=Aceptar
Comentarios=Lista(Info.Nombre, Info.Sucursal, Info.Descripcion)
PosicionInicialIzquierda=307
PosicionInicialArriba=162
PosicionInicialAlturaCliente=409
PosicionInicialAncho=409

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=NominaPremioSucAlcance
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
OtroOrden=S
ListaOrden=NominaPremioSucAlcance.Premio<TAB>(Decendente)
FiltroGeneral=NominaPremioSucAlcance.ID={Info.ID} AND NominaPremioSucAlcance.Sucursal={Info.Sucursal}

[Lista.NominaPremioSucAlcance.Premio]
Carpeta=Lista
Clave=NominaPremioSucAlcance.Premio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Porcentaje=69
Alcance=105
Premio=142
PorcentajeD=79
PorcentajeA=85

[Lista.NominaPremioSucAlcance.PorcentajeD]
Carpeta=Lista
Clave=NominaPremioSucAlcance.PorcentajeD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.NominaPremioSucAlcance.PorcentajeA]
Carpeta=Lista
Clave=NominaPremioSucAlcance.PorcentajeA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ListaEnCaptura]
(Inicio)=NominaPremioSucAlcance.PorcentajeD
NominaPremioSucAlcance.PorcentajeD=NominaPremioSucAlcance.PorcentajeA
NominaPremioSucAlcance.PorcentajeA=NominaPremioSucAlcance.Premio
NominaPremioSucAlcance.Premio=(Fin)
