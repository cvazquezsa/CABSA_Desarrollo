[Forma]
Clave=EmpresaGrupo
Nombre=<T>Grupos de Empresas/Sucursales<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
PosicionInicialIzquierda=319
PosicionInicialArriba=224
PosicionInicialAltura=319
PosicionInicialAncho=385
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
VentanaExclusiva=

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmpresaGrupo
Fuente={MS Sans Serif, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
HojaTitulos=S
HojaMostrarColumnas=S

[Lista.EmpresaGrupo.Grupo]
Carpeta=Lista
Clave=EmpresaGrupo.Grupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100

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
Grupo=293
ClaveConsecutivos=73
Clave=63

[Lista.EmpresaGrupo.Clave]
Carpeta=Lista
Clave=EmpresaGrupo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5

[Lista.ListaEnCaptura]
(Inicio)=EmpresaGrupo.Grupo
EmpresaGrupo.Grupo=EmpresaGrupo.Clave
EmpresaGrupo.Clave=(Fin)
