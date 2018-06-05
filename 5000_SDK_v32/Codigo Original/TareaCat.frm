[Forma]
Clave=TareaCat
Nombre=Categorías de Tareas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialIzquierda=500
PosicionInicialArriba=362
PosicionInicialAltura=300
PosicionInicialAncho=279
PosicionInicialAlturaCliente=273

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaCat
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=
HojaMostrarColumnas=
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaConfirmarEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TareaCat.Categoria
CarpetaVisible=S

[Lista.TareaCat.Categoria]
Carpeta=Lista
Clave=TareaCat.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=Si
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=Si
TipoAccion=Ventana
ClaveAccion=Aceptar
Visible=Si
Activo=Si
GuardarAntes=Si

[Lista.Columnas]
Categoria=250

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Excel
Excel=(Fin)
