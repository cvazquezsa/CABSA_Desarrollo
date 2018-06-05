[Forma]
Clave=CteExpress
Nombre=Agregar Cliente
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=2042
PosicionInicialArriba=195
PosicionInicialAltura=393
PosicionInicialAncho=556
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=461
ExpresionesAlMostrar=Asigna(Info.Cliente, Nulo)<BR>Asigna(CteX.Clave, General.CteExpressDef)<BR>Asigna(CteX.Delegacion, <T><T>)<BR>Asigna(CteX.Colonia, <T><T>)<BR>Asigna(CteX.CP, <T><T>)<BR>Asigna(CteX.Direccion, <T><T>)<BR>Asigna(CteX.Estado, <T><T>)<BR>Asigna(CteX.Nombre, <T><T>)<BR>Asigna(CteX.Pais, <T><T>)<BR>Asigna(CteX.Poblacion, <T><T>)<BR>Asigna(CteX.RFC, <T><T>)<BR>Asigna(CteX.Telefonos, <T><T>)<BR>Asigna(CteX.Contacto, <T><T>)<BR>Asigna(CteX.eMail, <T><T>)<BR>Asigna(CteX.Categoria, General.CteExpressCategoria)<BR>Asigna(CteX.Grupo, <T><T>)<BR>Asigna(CteX.Familia, <T><T>)<BR>Asigna(CteX.Ruta, <T><T>)<BR>Asigna(CteX.Agente, Usuario.DefAgente)<BR>Asigna(CteX.Comentarios, <T><T>)<BR>Asigna(CteX.Cuenta, <T><T>)<BR>Asigna(CteX.PersonalNombres, <T><T>)<BR>Asigna(CteX.PersonalApellidoPaterno, <T><T>)<BR>Asigna(CteX.PersonalApellidoMaterno, <T><T>)<BR>Asigna(Afectar.ID, Nulo)
ExpresionesAlCerrar=Asigna(Info.Copiar, falso)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
FichaEspacioEntreLineas=4
FichaEspacioNombres=81
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).CteX.Clave]
Carpeta=(Variables)
Clave=CteX.Clave
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
EspacioPrevio=N
IgnoraFlujo=S
ColorFondo=Blanco

[(Variables).CteX.Nombre]
Carpeta=(Variables)
Clave=CteX.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco

[(Variables).CteX.RFC]
Carpeta=(Variables)
Clave=CteX.RFC
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Telefonos]
Carpeta=(Variables)
Clave=CteX.Telefonos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Direccion]
Carpeta=(Variables)
Clave=CteX.Direccion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
EspacioPrevio=S
ColorFondo=Blanco

[(Variables).CteX.Poblacion]
Carpeta=(Variables)
Clave=CteX.Poblacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.CP]
Carpeta=(Variables)
Clave=CteX.CP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Pais]
Carpeta=(Variables)
Clave=CteX.Pais
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Estado]
Carpeta=(Variables)
Clave=CteX.Estado
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Colonia]
Carpeta=(Variables)
Clave=CteX.Colonia
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Guardar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Guardar.SQL]
Nombre=SQL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S

Expresion=Asigna(Info.Cliente, Nulo)<BR>Si<BR>  SQL(<T>SELECT COUNT(*) FROM ListaNegraColonia WHERE Colonia=:tColonia<T>, CteX.Colonia)>0<BR>Entonces<BR>  Si(Precaucion(<T>No Es posible Entregar en esa Colonia.<T>+NuevaLinea+<T>Favor de Revisar la Lista Negra.<T>+NuevaLinea+NuevaLinea+NuevaLinea+<T>¿ Desea Agregar el Cliente ?<T>, BotonNo, BotonSi)<>BotonSi, AbortarOperacion)<BR>Fin<BR><BR>Asigna(Info.Cliente, <BR>SQL(<T>spAgregarClienteExpress :tClave, :tNom, :tDir, :tDel, :tCol, :tRuta, :tPob, :tEstado, :tPais, :tCP, :tRFC, :tTel, :tContacto, :teMail, :tCat, :tGrupo, :tFam, :tAgente, :tTipo, :tComenta, :tMon, :tPre, :tLike, :nDig, :tCond, :tCredito, :nCPID, :tEmp, :tCta, :tNombres, :tPaterno, :tMaterno, :nLati, :nLongi, :tUbic, @Sucursal=:nSucursal, @FueraLinea=:lFueraLinea<T>,<BR>CteX.Clave, CteX.Nombre, CteX.Direccion, CteX.Delegacion, CteX.Colonia, CteX.Ruta, CteX.Poblacion, CteX.Estado, CteX.Pais, CteX.CP,<BR>CteX.RFC, CteX.Telefonos, CteX.Contacto, CteX.eMail, CteX.Categoria, CteX.Grupo, CteX.Familia, CteX.Agente, Info.Tipo, CteX.Comentarios, Config.ContMoneda,<BR>General.CteExpressPrefijo, General.CteExpressPrefijo+<T>[0-9]%<T>, General.CteExpressDigitos, General.DefCondicion, General.DefCredito, Afectar.ID, Empresa, CteX.Cuenta, CteX.PersonalNombres, CteX.PersonalApellidoPaterno, CteX.PersonalApellidoMaterno, Info.MapaLatitud, Info.MapaLongitud, Info.MapaUbicacion, Sucursal, Modo.FueraLinea))<BR><BR>Si<BR>  ConDatos(Info.Cliente)<BR>Entonces<BR>  EjecutarSQLLocal(<T>spAgregarClienteExpress :tClave, :tNom, :tDir, :tDel, :tCol, :tRuta, :tPob, :tEstado, :tPais, :tCP, :tRFC, :tTel, :tContacto, :teMail, :tCat, :tGrupo, :tFam, :tAgente, :tTipo, :tComenta, :tMon, :tPre, :tLike, :nDig, :tCond, :tCredito, :nCPID, :tEmp, :tCta, :tNombres, :tPaterno, :tMaterno, :nLati, :nLongi, :tUbic, @Sucursal=:nSucursal, @FueraLinea=:lFueraLinea<T>,<BR>  Info.Cliente, CteX.Nombre, CteX.Direccion, CteX.Delegacion, CteX.Colonia, CteX.Ruta, CteX.Poblacion, CteX.Estado, CteX.Pais, CteX.CP,<BR>  CteX.RFC, CteX.Telefonos, CteX.Contacto, CteX.eMail, CteX.Categoria, CteX.Grupo, CteX.Familia, CteX.Agente, Info.Tipo, CteX.Comentarios, Config.ContMoneda,<BR>  General.CteExpressPrefijo, General.CteExpressPrefijo+<T>[0-9]%<T>, General.CteExpressDigitos, General.DefCondicion, General.DefCredito, Afectar.ID, Empresa, CteX.Cuenta, CteX.PersonalNombres, CteX.PersonalApellidoPaterno, CteX.PersonalApellidoMaterno, Info.MapaLatitud, Info.MapaLongitud, Info.MapaUbicacion, Sucursal, Modo.FueraLinea)<BR>Fin
EjecucionCondicion=ConDatos(CteX.Nombre)
[Acciones.Guardar.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
ConCondicion=S
EjecucionCondicion=ConDatos(CteX.Nombre) y ConDatos(Info.Cliente)

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[(Variables).CteX.Categoria]
Carpeta=(Variables)
Clave=CteX.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Comentarios]
Carpeta=(Variables)
Clave=CteX.Comentarios
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
Multiple=S
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=(Lista)
Activo=S
Visible=S

[Acciones.Buscar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Buscar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Ventana
Activo=S
Visible=S
ClaveAccion=Aceptar
ConCondicion=S
EjecucionCondicion=Forma(<T>CteExpressLista<T>)

[Acciones.Buscar]
Nombre=Buscar
Boton=51
NombreEnBoton=S
NombreDesplegar=&Buscar
Multiple=S
EnBarraHerramientas=S
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion
Activo=S
Visible=S

[(Variables).CteX.Ruta]
Carpeta=(Variables)
Clave=CteX.Ruta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
LineaNueva=S

[(Variables).CteX.Contacto]
Carpeta=(Variables)
Clave=CteX.Contacto
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
EspacioPrevio=N
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.eMail]
Carpeta=(Variables)
Clave=CteX.eMail
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Grupo]
Carpeta=(Variables)
Clave=CteX.Grupo
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Familia]
Carpeta=(Variables)
Clave=CteX.Familia
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.ListaNegra]
Nombre=ListaNegra
Boton=22
NombreEnBoton=S
NombreDesplegar=&Lista Negra Ctos
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ListaNegraLista
Activo=S
Visible=S

[(Variables).CteX.Delegacion]
Carpeta=(Variables)
Clave=CteX.Delegacion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.Agente]
Carpeta=(Variables)
Clave=CteX.Agente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.ListaNegraZonas]
Nombre=ListaNegraZonas
Boton=22
NombreEnBoton=S
NombreDesplegar=Lista Negra Zonas
EnBarraHerramientas=S
TipoAccion=Formas
Activo=S
Visible=S
ClaveAccion=ListaNegraColoniaLista

[(Variables).CteX.Cuenta]
Carpeta=(Variables)
Clave=CteX.Cuenta
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.PersonalNombres]
Carpeta=(Variables)
Clave=CteX.PersonalNombres
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.PersonalApellidoMaterno]
Carpeta=(Variables)
Clave=CteX.PersonalApellidoMaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[(Variables).CteX.PersonalApellidoPaterno]
Carpeta=(Variables)
Clave=CteX.PersonalApellidoPaterno
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco




[Acciones.Mapa]
Nombre=Mapa
Boton=106
NombreDesplegar=Ubicación
EnBarraHerramientas=S
TipoAccion=Otros
ClaveAccion=Mapa
ListaParametros1=Info.MapaLatitud<BR>Info.MapaLongitud<BR> <BR> <BR>Info.MapaUbicacion
ListaParametros=S
Activo=S
Visible=S


NombreEnBoton=S
EspacioPrevio=S
[(Variables).ListaEnCaptura]
(Inicio)=CteX.Nombre
CteX.Nombre=CteX.Telefonos
CteX.Telefonos=CteX.RFC
CteX.RFC=CteX.Clave
CteX.Clave=CteX.Direccion
CteX.Direccion=CteX.CP
CteX.CP=CteX.Delegacion
CteX.Delegacion=CteX.Colonia
CteX.Colonia=CteX.Poblacion
CteX.Poblacion=CteX.Estado
CteX.Estado=CteX.Pais
CteX.Pais=CteX.Ruta
CteX.Ruta=CteX.Contacto
CteX.Contacto=CteX.eMail
CteX.eMail=CteX.PersonalNombres
CteX.PersonalNombres=CteX.PersonalApellidoPaterno
CteX.PersonalApellidoPaterno=CteX.PersonalApellidoMaterno
CteX.PersonalApellidoMaterno=CteX.Categoria
CteX.Categoria=CteX.Grupo
CteX.Grupo=CteX.Familia
CteX.Familia=CteX.Agente
CteX.Agente=CteX.Cuenta
CteX.Cuenta=CteX.Comentarios
CteX.Comentarios=Info.MapaUbicacion
Info.MapaUbicacion=(Fin)

[(Variables).Info.MapaUbicacion]
Carpeta=(Variables)
Clave=Info.MapaUbicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=62
ColorFondo=Blanco
















[Acciones.Guardar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=SQL
SQL=Cerrar
Cerrar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Cancelar
Cancelar=Buscar
Buscar=ListaNegra
ListaNegra=ListaNegraZonas
ListaNegraZonas=Mapa
Mapa=(Fin)
