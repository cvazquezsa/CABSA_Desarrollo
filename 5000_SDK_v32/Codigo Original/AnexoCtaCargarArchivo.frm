
[Forma]
Clave=AnexoCtaCargarArchivo
Icono=0
Modulos=(Todos)
Nombre=Especificar Dirección
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=Aceptar
PosicionInicialIzquierda=596
PosicionInicialArriba=326
PosicionInicialAlturaCliente=170
PosicionInicialAncho=407
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
ExpresionesAlMostrar=Asigna(Info.Archivo,Nulo)  <BR>Asigna(Info.Archivo2,Nulo)<BR>Asigna(Info.Archivo3,Nulo)<BR>Asigna(Info.Directorio,Nulo)<BR>Asigna(Info.Clase2,Nulo)<BR>Asigna(Info.Clase3,Nulo)
[Acciones.Aceptar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Aceptar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Si(ConDatos(Info.Archivo),Asigna(Info.Directorio,(Upload(Info.Archivo,<T>Prueba<T>))))<BR>Si(ConDatos(Info.Archivo2),Asigna(Info.Clase2,(Upload(Info.Archivo2,<T>Prueba<T>))))<BR>Si(ConDatos(Info.Archivo3),Asigna(Info.Clase3,(Upload(Info.Archivo3,<T>Prueba<T>))))
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

PermiteEditar=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Plata
[(Variables).Info.Archivo]
Carpeta=(Variables)
Clave=Info.Archivo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Aceptar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S






[(Variables).Info.Archivo2]
Carpeta=(Variables)
Clave=Info.Archivo2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[(Variables).Info.Archivo3]
Carpeta=(Variables)
Clave=Info.Archivo3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Acciones.Aceptar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Aceptar
Aceptar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.Archivo
Info.Archivo=Info.Archivo2
Info.Archivo2=Info.Archivo3
Info.Archivo3=(Fin)
