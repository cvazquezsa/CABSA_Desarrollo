[Forma]
Clave=mcMayor
Nombre=Cuentas de Mayor
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=568
PosicionInicialArriba=304
PosicionInicialAlturaCliente=555
PosicionInicialAncho=784
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
PosicionCol1=507
ExpresionesAlMostrar=MC.TablaGet(<T>mcCampo<T>)<BR>MC.TablaGet(<T>mcMayor<T>)<BR>MC.TablaGet(<T>mcMayorDato<T>)

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=mcMayor
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
CarpetaVisible=S
HojaMantenerSeleccion=S

[Lista.mcMayor.Mayor]
Carpeta=Lista
Clave=mcMayor.Mayor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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
Antes=S
DespuesGuardar=S
AntesExpresiones=MC.TablaPost(<T>mcMayor<T>)<BR>MC.TablaPost(<T>mcMayorDato<T>)

[Lista.Columnas]
Mayor=124
Descripcion=604
Nombre=351
Nivel1=166
Nivel2=164
Nivel3=174
Rama=124
EsAcreedora=68
EsAcumulativa=76

[Acciones.Medidas]
Nombre=Medidas
Boton=47
NombreEnBoton=S
NombreDesplegar=&Medidas
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=mcMayorMedida
Visible=S
GuardarAntes=S
ConCondicion=S
Antes=S
ActivoCondicion=no mcMayor:mcMayor.EsAcumulativa
EjecucionCondicion=ConDatos(mcMayor:mcMayor.Mayor)
AntesExpresiones=Asigna(Info.Mayor, mcMayor:mcMayor.Mayor)

[Lista.mcMayor.Nombre]
Carpeta=Lista
Clave=mcMayor.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcMayor.Nivel1]
Carpeta=Ficha
Clave=mcMayor.Nivel1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcMayor.Nivel2]
Carpeta=Ficha
Clave=mcMayor.Nivel2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.mcMayor.Nivel3]
Carpeta=Ficha
Clave=mcMayor.Nivel3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayor.Rama]
Carpeta=Lista
Clave=mcMayor.Rama
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayor.EsAcreedora]
Carpeta=Lista
Clave=mcMayor.EsAcreedora
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.mcMayor.EsAcumulativa]
Carpeta=Lista
Clave=mcMayor.EsAcumulativa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Datos]
Nombre=Datos
Boton=47
NombreEnBoton=S
NombreDesplegar=&Datos
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=mcMayorDato
ActivoCondicion=no mcMayor:mcMayor.EsAcumulativa
ConCondicion=S
EjecucionCondicion=ConDatos(mcMayor:mcMayor.Mayor)
Antes=S
AntesExpresiones=Asigna(Info.Mayor, mcMayor:mcMayor.Mayor)
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Datos
Datos=Medidas
Medidas=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=mcMayor.Mayor
mcMayor.Mayor=mcMayor.Nombre
mcMayor.Nombre=mcMayor.Rama
mcMayor.Rama=mcMayor.EsAcumulativa
mcMayor.EsAcumulativa=mcMayor.EsAcreedora
mcMayor.EsAcreedora=(Fin)
