
[Forma]
Clave=ArtVenta
Icono=21
Modulos=(Todos)
Nombre=<T>Ventas <T> & <T>(<T> & Info.Articulo & <T>)<T>
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=553
PosicionInicialArriba=290
PosicionInicialAlturaCliente=108
PosicionInicialAncho=259
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
VentanaEscCerrar=S
VentanaExclusiva=S
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Centrado
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
[Lista.ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[Lista.Info.FechaD]
Carpeta=Lista
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Info.FechaA]
Carpeta=Lista
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
EnBarraHerramientas=S
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)
[Acciones.Aceptar.Asigna]
Nombre=Asigna
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Ejecuta]
Nombre=Ejecuta
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S






















Expresion=Asigna(Temp.Texto, Info.Articulo & <T>|<T> & Año(Info.FechaD) & Derecha(<T>00<T> & Mes(Info.FechaD), 2) & Derecha(<T>00<T> & Dia(Info.FechaD), 2) & <T>|<T> & Año(Info.FechaA) & Derecha(<T>00<T> & Mes(Info.FechaA), 2) & Derecha(<T>00<T> & Dia(Info.FechaA), 2) & <T>|SEMANA<T>)<BR>PlugIn(<T>ArtVenta<T>, Temp.Texto)<BR>Forma.Accion(<T>Cancelar<T>)
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








































[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Asigna
Asigna=Ejecuta
Ejecuta=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
