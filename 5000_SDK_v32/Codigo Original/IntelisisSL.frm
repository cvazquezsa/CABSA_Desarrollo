
[Forma]
Clave=IntelisisSL
Icono=22
Modulos=(Todos)
Nombre=Licencias del Cliente

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialIzquierda=192
PosicionInicialArriba=166
PosicionInicialAlturaCliente=399
PosicionInicialAncho=981
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
PosicionCol1=695
[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=IntelisisSL
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=Predefinido
HojaPermiteInsertar=S
HojaIndicador=S
FiltroPredefinido1=por Licencia<BR>por Vencimiento<BR>por Mantenimiento
FiltroPredefinido2=1=1<BR>1=1<BR>1=1
FiltroPredefinido3=Licencia<BR>Vencimiento<BR>Mantenimiento
FiltroEstilo=Directorio
PermiteEditar=S
FiltroGeneral=IntelisisSL.Cliente=<T>{Info.Cliente}<T>
[Lista.IntelisisSL.Licencia]
Carpeta=Lista
Clave=IntelisisSL.Licencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.IntelisisSL.Nombre]
Carpeta=Lista
Clave=IntelisisSL.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=255
ColorFondo=Blanco

[Lista.IntelisisSL.Vencimiento]
Carpeta=Lista
Clave=IntelisisSL.Vencimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.IntelisisSL.Estatus]
Carpeta=Lista
Clave=IntelisisSL.Estatus
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Licencia=75
Nombre=203
Vencimiento=81
Observaciones=260
Estatus=55

Fabricacion=94
Mantenimiento=84
Liberado=47
Tipo=54
Firma=244
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


[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Licenciamientos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=IntelisisSLD
Activo=S
ConCondicion=S
Antes=S
Visible=S


























EjecucionCondicion=ConDatos(IntelisisSL:IntelisisSL.Licencia)
AntesExpresiones=Asigna(Info.Clave, IntelisisSL:IntelisisSL.Licencia)<BR>Asigna(Info.Nombre, IntelisisSL:IntelisisSL.Nombre)
[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
NombreDesplegar=&Bitácora Acceso
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=IntelisisSLLog
Activo=S
ConCondicion=S
Antes=S
Visible=S



























EspacioPrevio=S
EjecucionCondicion=ConDatos(IntelisisSL:IntelisisSL.Licencia)
AntesExpresiones=Asigna(Info.Clave, IntelisisSL:IntelisisSL.Licencia)<BR>Asigna(Info.Nombre, IntelisisSL:IntelisisSL.Nombre)
[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S


EspacioPrevio=S
[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=Lista
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Visible=S












ConfirmarAntes=S
ActivoCondicion=no IntelisisSL:IntelisisSL.TieneMovimientos

[Acciones.Hist]
Nombre=Hist
Boton=53
NombreDesplegar=&Histórico
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=IntelisisSLHist
Activo=S
Visible=S





















[Lista.IntelisisSL.Fabricacion]
Carpeta=Lista
Clave=IntelisisSL.Fabricacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.IntelisisSL.Mantenimiento]
Carpeta=Lista
Clave=IntelisisSL.Mantenimiento
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




[Lista.IntelisisSL.Tipo]
Carpeta=Lista
Clave=IntelisisSL.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco






[Acciones.XML]
Nombre=XML
Boton=57
NombreEnBoton=S
NombreDesplegar=&Ver Ultima Licencia Generada
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=IntelisisSLXML
Activo=S
Visible=S







Antes=S




ConCondicion=S



EjecucionCondicion=ConDatos(IntelisisSL:IntelisisSL.Licencia)
AntesExpresiones=Asigna(Info.Clave, IntelisisSL:IntelisisSL.Licencia)<BR>Asigna(Info.Nombre, IntelisisSL:IntelisisSL.Nombre)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=IntelisisSL
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

PermiteEditar=S
[Ficha.IntelisisSL.Observaciones]
Carpeta=Ficha
Clave=IntelisisSL.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35x5
ColorFondo=Blanco

EspacioPrevio=S
[Ficha.IntelisisSL.Contacto]
Carpeta=Ficha
Clave=IntelisisSL.Contacto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco

[Ficha.IntelisisSL.eMail]
Carpeta=Ficha
Clave=IntelisisSL.eMail
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco







[Ficha.IntelisisSL.Firma]
Carpeta=Ficha
Clave=IntelisisSL.Firma
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco















[Lista.ListaEnCaptura]
(Inicio)=IntelisisSL.Licencia
IntelisisSL.Licencia=IntelisisSL.Nombre
IntelisisSL.Nombre=IntelisisSL.Fabricacion
IntelisisSL.Fabricacion=IntelisisSL.Vencimiento
IntelisisSL.Vencimiento=IntelisisSL.Mantenimiento
IntelisisSL.Mantenimiento=IntelisisSL.Tipo
IntelisisSL.Tipo=IntelisisSL.Estatus
IntelisisSL.Estatus=(Fin)




[Ficha.ListaEnCaptura]
(Inicio)=IntelisisSL.Firma
IntelisisSL.Firma=IntelisisSL.Dominio
IntelisisSL.Dominio=IntelisisSL.Contacto
IntelisisSL.Contacto=IntelisisSL.eMail
IntelisisSL.eMail=IntelisisSL.Observaciones
IntelisisSL.Observaciones=(Fin)

[Ficha.IntelisisSL.Dominio]
Carpeta=Ficha
Clave=IntelisisSL.Dominio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35
ColorFondo=Blanco



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Ficha
Ficha=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Detalle
Detalle=XML
XML=Bitacora
Bitacora=Hist
Hist=(Fin)
