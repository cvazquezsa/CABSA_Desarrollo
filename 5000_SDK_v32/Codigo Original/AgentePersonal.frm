[Forma]
Clave=AgentePersonal
Nombre=Personal Asignado
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Info.Agente
PosicionInicialIzquierda=248
PosicionInicialArriba=194
PosicionInicialAlturaCliente=345
PosicionInicialAncho=527
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=AgentePersonal
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
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
FiltroGeneral=AgentePersonal.Agente=<T>{Info.Agente}<T>

[Lista.AgentePersonal.Personal]
Carpeta=Lista
Clave=AgentePersonal.Personal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Personal.Nombre]
Carpeta=Lista
Clave=Personal.Nombre
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Gris

[Lista.Personal.ApellidoPaterno]
Carpeta=Lista
Clave=Personal.ApellidoPaterno
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Gris

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
Personal=129
Nombre=184
ApellidoPaterno=183

[Lista.ListaEnCaptura]
(Inicio)=AgentePersonal.Personal
AgentePersonal.Personal=Personal.Nombre
Personal.Nombre=Personal.ApellidoPaterno
Personal.ApellidoPaterno=(Fin)
