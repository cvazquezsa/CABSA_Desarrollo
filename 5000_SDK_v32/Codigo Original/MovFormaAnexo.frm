[Forma]
Clave=MovFormaAnexo
Nombre=e(<T>Formas Anexas<T>)+<T> - <T>+Info.Mov+<T> <T>+Info.MovID
Icono=730
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=604
PosicionInicialArriba=389
PosicionInicialAlturaCliente=394
PosicionInicialAncho=711
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovFormaAnexo
Fuente={Tahoma, 8, Negro, []}
IconosCampo=Icono
IconosEstilo=Iconos grandes
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Forma Anexa<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PestanaOtroNombre=S
MenuLocal=S
ListaAcciones=(Lista)
ListaEnCaptura=(Lista)
IconosNombre=MovFormaAnexo:Nombre

[Lista.Columnas]
0=154
1=110

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Lista.Usuario]
Carpeta=Lista
Clave=Usuario
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UltimoCambio]
Carpeta=Lista
Clave=UltimoCambio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cambiar Estilo (Iconos)]
Nombre=Cambiar Estilo (Iconos)
Boton=0
NombreDesplegar=Cambiar Estilo (Iconos)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Estilo (Iconos)
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=0
NombreDesplegar=E&liminar
EnMenu=S
ConfirmarAntes=S
TipoAccion=Expresion
Visible=S
RefrescarIconos=S
Expresion=Asigna(Anexo.Modulo, Info.Modulo)<BR>Asigna(Anexo.ID, Info.ID)<BR>Asigna(Anexo.Mov, Info.Mov)<BR>Asigna(Anexo.MovID, Info.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>Reexpresa(SQL(<T>SELECT ExpresionesAlEliminar FROM MovTipoFormaAnexo WHERE Modulo=:tModulo AND Mov=:tMov AND Nombre=:tNombre<T>, Anexo.Modulo, Anexo.Mov, Anexo.Nombre))<BR>MovFormaAnexo.Eliminar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo)
Activo=S
ConCondicion=S
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave) y (MovFormaAnexo:Icono=731)

[Acciones.Abrir]
Nombre=Abrir
Boton=0
NombreDesplegar=Si(MovFormaAnexo:Icono=731, <T>&Abrir<T>, <T>&Crear<T>)<TAB>
RefrescarIconos=S
EnMenu=S
TipoAccion=Expresion
Activo=S
ConCondicion=S
Visible=S
EsDefault=S
Expresion=Asigna(Anexo.Modulo, Info.Modulo)<BR>Asigna(Anexo.ID, Info.ID)<BR>Asigna(Anexo.Mov, Info.Mov)<BR>Asigna(Anexo.MovID, Info.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>Reexpresa(SQL(<T>SELECT ExpresionesAlAbrir FROM MovTipoFormaAnexo WHERE Modulo=:tModulo AND Mov=:tMov AND Nombre=:tNombre<T>, Anexo.Modulo, Anexo.Mov, Anexo.Nombre))<BR>MovFormaAnexo(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, Anexo.Mov, Anexo.MovID)
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave)

[Acciones.Anexar]
Nombre=Anexar
Boton=0
NombreDesplegar=Ane&xar...
EnMenu=S
TipoAccion=Expresion
Visible=S
RefrescarIconos=S
EspacioPrevio=S
Activo=S
Expresion=Asigna(Anexo.Modulo, Info.Modulo)<BR>Asigna(Anexo.ID, Info.ID)<BR>Asigna(Anexo.Mov, Info.Mov)<BR>Asigna(Anexo.MovID, Info.MovID)<BR>Asigna(Anexo.Clave, MovFormaAnexo:Clave)<BR>Asigna(Anexo.Nombre, MovFormaAnexo:Nombre)<BR>Asigna(Anexo.Tipo, MovFormaAnexo:Tipo)<BR>Reexpresa(SQL(<T>SELECT ExpresionesAlAnexar FROM MovTipoFormaAnexo WHERE Modulo=:tModulo AND Mov=:tMov AND Nombre=:tNombre<T>, Anexo.Modulo, Anexo.Mov, Anexo.Nombre))<BR>MovFormaAnexo.Anexar(Anexo.Modulo, Anexo.ID, Anexo.Clave, Anexo.Nombre, Anexo.Tipo, BuscarArchivo(<T><T>, Anexo.Clave+<T>.xml<T>, <T>xml<T>, Anexo.Clave, <T>Formas InfoPath<T>))
ConCondicion=S
EjecucionCondicion=ConDatos(MovFormaAnexo:Clave) y (MovFormaAnexo:Icono=732)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Cambiar Estilo (Iconos)
Cambiar Estilo (Iconos)=(Fin)

[Lista.ListaAcciones]
(Inicio)=Abrir
Abrir=Anexar
Anexar=Eliminar
Eliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Usuario
Usuario=UltimoCambio
UltimoCambio=(Fin)
