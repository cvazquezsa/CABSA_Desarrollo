
[Forma]
Clave=TipoEmpresa
Icono=0
Modulos=(Todos)
Nombre=Tipos de Empresa

ListaCarpetas=TipoEmpresa
CarpetaPrincipal=TipoEmpresa
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=439
PosicionInicialArriba=161
PosicionInicialAlturaCliente=387
PosicionInicialAncho=346


VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Refrescar Controles]
Nombre=Refrescar Controles
Boton=67
NombreDesplegar=&EnvioExcel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Activo=S
Visible=S


EspacioPrevio=S
[TipoEmpresaLista.Columnas]
TipoEmpresaID=48
Descripcion=362



[TipoEmpresaLista.ListaEnCaptura]
(Inicio)=TipoEmpresa.TipoEmpresaID
TipoEmpresa.TipoEmpresaID=TipoEmpresa.Descripcion
TipoEmpresa.Descripcion=(Fin)


























[TipoEmpresa]
Estilo=Hoja
Clave=TipoEmpresa
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TipoEmpresa
Fuente={Tahoma, 8, Negro, []}
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=TipoEmpresa.Descripcion
CarpetaVisible=S

[TipoEmpresa.TipoEmpresa.Descripcion]
Carpeta=TipoEmpresa
Clave=TipoEmpresa.Descripcion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro














[TipoEmpresa.Columnas]
Descripcion=316









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Refrescar Controles
Refrescar Controles=(Fin)
